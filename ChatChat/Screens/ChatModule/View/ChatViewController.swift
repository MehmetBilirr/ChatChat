//
//  ChatViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import MessageKit
import InputBarAccessoryView
import SnapKit
import MapKit

class ChatViewController:MessagesViewController {
    var presenter: ViewToPresenterChatProtocol?
    private var messages = [Message]()
    private var selfSender : SenderType?
    var chosenUser:User?
    var chosenConversation:Conversation?
    let viewChat = ChatStatusView(frame: .zero)
    private var otherID:String {
        let otId = chosenConversation == nil ? chosenUser!.uid : chosenConversation!.user_id
        return otId
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatRouter.createModule(ref: self, navigationController: navigationController!)
        presenter?.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getChats(otherId: otherID)
        presenter?.configureChatStatusView(view: viewChat)
    }
    
    func configureView(){
        view.addSubview(viewChat)
        viewChat.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalToSuperview()
        }
    }
    
}

extension ChatViewController:MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender!
    }
    
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}

extension ChatViewController:InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {return}
        
        presenter?.sendMessage(text: text, otherUserId: otherID, sender: selfSender!)
    }
    
}

extension ChatViewController: MessageCellDelegate {
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        if sender.senderId == selfSender!.senderId {
            presenter?.configureAvatarView(uid: sender.senderId, avatarView: avatarView)
        }else {
            
            presenter?.configureAvatarView(uid: otherID, avatarView: avatarView)
        }
    }
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let message = message as? Message else {return}
        switch message.kind {
            
        case .photo(let media):
            guard let imageUrl = media.url else {return}
            imageView.sd_setImage(with: imageUrl)
        default:
            break
        }
    }
    
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = self.messagesCollectionView.indexPath(for: cell) else {return}
        let message = messages[indexPath.section]
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {return}
            let vc = PhotoViewerViewController(with: imageUrl)
            
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
        
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = self.messagesCollectionView.indexPath(for: cell) else {return}
        let message = messages[indexPath.section]
        switch message.kind {
        case.location(let locationData):
            let vc = LocationViewController(coordinates: locationData.location.coordinate)
            vc.title = "Location"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let sender = message.sender
        if sender.senderId == selfSender?.senderId {
            // current user
            return .blue.lighter()
        }
        return .secondarySystemBackground
    }
    
}

extension ChatViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentPhotoInputActionSheet(){
        let actionSheet = UIAlertController(title: ActionNames.attachMedia.rawValue, message: "Where would you like to attacth?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Camera.rawValue, style: .default, handler: { [weak self] _ in
            self?.pickerView(typeSource: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.photoLibrary.rawValue, style: .default, handler: { [weak self] _ in
            self?.pickerView(typeSource: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Cancel.rawValue, style: .cancel))
        
        present(actionSheet, animated: true)
        
    }
    
    private func pickerView(typeSource:UIImagePickerController.SourceType){
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
        pickerVC.sourceType = typeSource
        self.present(pickerVC,animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        let imageView = UIImageView()
        imageView.image = selectedImage
        presenter?.didFinishPickingMedia(receiverId: otherID, imageView: imageView, sender: selfSender!)
        self.dismiss(animated: true)
    }
    
    
}

extension ChatViewController:PresenterToViewChatProtocol {
    func configureCollectionView() {
        view.backgroundColor = .systemGreen.lighter()
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messageInputBar.delegate = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.backgroundColor = .systemGreen.lighter()
        
        
        
    }
    
    func configureInputButton(){
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 35, height: 35), animated: false)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.onTouchUpInside { [weak self] _ in
            self?.presentInputActionSheet()
        }
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.backgroundView.backgroundColor = .systemGreen.lighter()
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
        
        
        
    }
    
    private func presentInputActionSheet(){
        let actionSheet = UIAlertController(title: ActionNames.attachMedia.rawValue, message: "What would you like to attach?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Photo.rawValue, style: .default, handler: { _ in
            self.presentPhotoInputActionSheet()
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Video.rawValue, style: .default, handler: {  _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Audio.rawValue, style: .default, handler: {  _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Location.rawValue, style: .default, handler: {  _ in
            self.presentLocationPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: ActionNames.Cancel.rawValue, style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func presentLocationPicker() {
        presenter?.sendLocationMessage(receiverId: otherID, sender: selfSender!)
        
    }
    
    
    
    func reloadData() {
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
        
    }
    
    func messageArray(messageArray: [Message]) {
        messages = messageArray
        messageInputBar.inputTextView.text = nil
        
    }
    func selfSender(sender: SenderType) {
        selfSender = sender
    }
    
    
    func configureBarButton() {
        let  videoButton = UIBarButtonItem(image: UIImage(systemName: "video"),style: .done,target: self, action: nil)
        let phoneButton = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [phoneButton,videoButton]
       
    }
}
