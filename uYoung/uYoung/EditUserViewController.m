//
//  EditUserViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EditUserViewController.h"
#import "NSString+StringUtil.h"
#import <UIImageView+AFNetworking.h>
#import "UIWindow+YoungHUD.h"
#import "CityModel.h"

@interface EditUserViewController ()

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backCoverImageView.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    [self initPicker];
    [self initUser];
    [self updateConstraints];
    _isKeyboardHidden = YES;
    
    [_nicknameImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _nicknameInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_genderImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_genderBackImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO]];
    [_locationImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_locationBackImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO]];
    [_companyImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _companyInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_positionImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    _positionInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO];
    [_emailImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _emailInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_mobileImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    _mobileInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO];
    [_equipmentImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    _equipmentInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    
    //增加键盘事件监听
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUser{
    if (_loginUser==nil||[NSString isBlankString:_loginUser.avatarUrl]) {
        _loginUser = [UserDetailModel currentUser];
    }
    if (_loginUser&&![_loginUser isEqual:[NSNull null]]) {
        //设置昵称
        if ([NSString isBlankString:_loginUser.nickName]==NO) {
            [_nicknameInput setText:_loginUser.nickName];
        }
        //设置头像
        if ([NSString isBlankString:_loginUser.avatarUrl]==NO) {
            __weak UIButton *weak = _userHeaderButton;
            NSString *avatarUrl = _loginUser.avatarUrl;
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2000.0];
            [_userHeaderButton.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                [weak setBackgroundImage:image forState:UIControlStateNormal];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                UIImage *img = [UIImage imageNamed:UserDefaultHeader];
                [weak setBackgroundImage:img forState:UIControlStateNormal];
            }];
        }
        //设置性别
        if (_loginUser.gender==1) {//男
            [_femaleButton setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
            [_maleButton setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
            _gender = 1;
        }else{
            [_femaleButton setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
            [_maleButton setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
            _gender = 2;
        }
        
        //设置区域
        if (_cityarr&&[_cityarr count]>0) {
            if (_cityId==0) {
                _cityId = _loginUser.cityId;
            }
            if (_locationId==0) {
                _locationId = _loginUser.locationId;
            }
            NSString *cityName;
            NSString *locationName;
            for (int i=0; i<[_cityarr count]; i++) {
                CityModel *city = _cityarr[i];
                if (city.id == _cityId) {
                    [_citySelector selectRow:i inComponent:0 animated:YES];//设置滚轮默认选中
                    cityName = city.cnName;
                    NSArray *subs = city.subDictCityList;
                    if (subs&&[subs count]>0) {
                        _locationArr = subs;
                        for (int j=0; j<[subs count]; j++) {
                            CityModel *location = subs[j];
                            if (location.id == _locationId) {
                                [_citySelector selectRow:j inComponent:1 animated:YES];
                                locationName = location.cnName;
                            }
                        }
                    }else{
                        locationName = cityName;
                    }
                }
            }
            [_locationSelButton setTitle:[NSString stringWithFormat:@"%@ - %@", cityName, locationName] forState:UIControlStateNormal];
        }
        
        //设置公司
        if ([NSString isBlankString:_loginUser.company]==NO) {
            [_companyInput setText:_loginUser.company];
        }
        //设置职位
        if ([NSString isBlankString:_loginUser.position]==NO) {
            [_positionInput setText:_loginUser.position];
        }
        //设置邮箱
        if ([NSString isBlankString:_loginUser.email]==NO) {
            [_emailInput setText:_loginUser.email];
        }
        //设置手机
        if ([NSString isBlankString:_loginUser.phone]==NO) {
            [_mobileInput setText:_loginUser.phone];
        }
        //设置器材
        if ([NSString isBlankString:_loginUser.equipment]==NO) {
            [_equipmentInput setText:_loginUser.equipment];
        }
        
    }

}

- (void)updateConstraints{
    CGFloat headerSize;
    CGFloat distance;
    CGFloat tinyImageW;
    CGFloat largeImageW;
    CGFloat top;
    CGFloat sep;
    CGFloat height;
    CGFloat genderSel;
    if (mScreenWidth==375) {//iPhone 6
        headerSize = 74.f;
        distance = 30.f;
        tinyImageW = 82.f;
        largeImageW = 100.f;
        top = 40.f;
        sep = 2.f;
        height = 40.f;
        genderSel = 16.f;
    }else if(mScreenWidth>375){//iPhone 6+
        headerSize = 90.f;
        distance = 38.f;
        tinyImageW = 90.f;
        largeImageW = 110.f;
        top = 50.f;
        sep = 4.f;
        height = 44.f;
        genderSel = 10.f;
    }else if(mScreenWidth<375&&mScreenHeight>480){//iPhone 5
        headerSize = 60.f;
        distance = 18.f;
        tinyImageW = 64.f;
        largeImageW = 80.f;
        top = 26.f;
        sep = 2.f;
        height = 40.f;
        genderSel = 2.f;
    }else{
        return;
    }
    
    UIView *content = [self.view viewWithTag:620];
    NSArray *views = content.subviews;
    if (views&&[views count]>0) {
        for (int i=0; i<[views count]; i++) {
            UIView *view = views[i];
            NSArray *consarr = view.constraints;
            if (consarr&&[consarr count]>0) {
                for (int j=0; j<[consarr count]; j++) {
                    NSLayoutConstraint *cons = consarr[j];
                    if(cons&&[cons.identifier hasPrefix:@"h_"]){
                        [cons setConstant:height];
                    }
                }
            }
        }
    }
    
    [_userHeaderButtonH setConstant:headerSize];
    [_userHeaderButtonW setConstant:headerSize];
    [_nicknameImageW setConstant:tinyImageW];
    [_genderImageW setConstant:tinyImageW];
    [_locationImageW setConstant:largeImageW];
    [_companyImageW setConstant:largeImageW];
    [_positionImageW setConstant:largeImageW];
    [_emailImageW setConstant:largeImageW];
    [_mobileImageW setConstant:largeImageW];
    [_equipmentImageW setConstant:largeImageW];
    
    [_firstDistanceCons setConstant:distance];
    [_secondDistanceCons setConstant:distance];
    [_thirdDistanceCons setConstant:distance];
    [_fourthDistanceCons setConstant:distance];
    
    [_topCons setConstant:top];
    
    [_firstSepCons setConstant:sep];
    [_secondSepCons setConstant:sep];
    [_thirdSepCons setConstant:sep];
    
    [_headerTopCons setConstant:top];
    
    [_genderSelCons setConstant:genderSel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPicker{
    _citySelector = [[UIPickerView alloc] initWithFrame:CGRectMake(0, mScreenHeight/2, mScreenWidth, mScreenHeight/2-60)];
    // 显示选中框
    _citySelector.showsSelectionIndicator=YES;
    _citySelector.dataSource = self;
    _citySelector.delegate = self;
    _citySelector.backgroundColor = UIColorFromRGB(0x85b200);
    [self.view addSubview:_citySelector];
    [_citySelector setHidden:YES];
    
    NSData *citylistdata = [[NSUserDefaults standardUserDefaults]objectForKey:@"citylist"];
    if (citylistdata) {
        _cityarr = [NSKeyedUnarchiver unarchiveObjectWithData:citylistdata];
    } else {
        _cityarr = [[NSArray alloc]init];
    }

    NSInteger selectedCityIndex = [_citySelector selectedRowInComponent:0];
    CityModel *parentCity = [_cityarr objectAtIndex:selectedCityIndex];
    
    _locationArr = [parentCity subDictCityList];
    
    //创建选择按钮
    _selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(0, mScreenHeight-60, mScreenWidth/2, 60)];
    _selectedButton.backgroundColor = UIColorFromRGB(0x85b200);
    [_selectedButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_selectedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectedButton];
    [_selectedButton setHidden:YES];
    //创建取消按钮
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(mScreenWidth/2, mScreenHeight-60, mScreenWidth/2, 60)];
    _cancelButton.backgroundColor = UIColorFromRGB(0x85b200);
    [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    [_cancelButton setHidden:YES];
}

-(void) buttonPressed:(id)sender{
    
    NSInteger selectedCityIndex = [_citySelector selectedRowInComponent:0];
    CityModel *parentCity = [_cityarr objectAtIndex:selectedCityIndex];
    NSString *city = parentCity.cnName;
    
    _locationArr = [parentCity subDictCityList];
    
    NSInteger rowlocation = [_citySelector selectedRowInComponent:1];
    CityModel *locationCity = [_locationArr objectAtIndex:rowlocation];
    NSString *location = locationCity.cnName;
    
    [_locationSelButton setTitle:[NSString stringWithFormat:@"%@ - %@", city, location] forState:UIControlStateNormal];
    [_locationSelImage setImage:[UIImage imageNamed:@"uyoung.bundle/down_arrow"]];
    [_selectedButton setHidden:YES];
    [_cancelButton setHidden:YES];
    [_citySelector setHidden:YES];
}

-(void) cancelPressed:(id)sender{
    [_locationSelImage setImage:[UIImage imageNamed:@"uyoung.bundle/down_arrow"]];
    [_selectedButton setHidden:YES];
    [_cancelButton setHidden:YES];
    [_citySelector setHidden:YES];
}

#pragma mark UIPickerView回调
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//城市个数
        return [_cityarr count];
    } else {//区域个数
        return [_locationArr count];
    }
}

//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择城市
        CityModel *city = [_cityarr objectAtIndex:row];
        return city.cnName;
    } else {//选择地区
        CityModel *location = [_locationArr objectAtIndex:row];
        return location.cnName;
    }
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        CityModel *seletedCityModel = [_cityarr objectAtIndex:row];
        _cityId = seletedCityModel.id;
        _locationArr = seletedCityModel.subDictCityList;
        
        //重点！更新第二个轮子的数据
        [_citySelector reloadComponent:1];
        
        NSInteger selectedLocationIndex = [_citySelector selectedRowInComponent:1];
        CityModel *selectedLocationModel = [_locationArr objectAtIndex:selectedLocationIndex];
        _locationId = selectedLocationModel.id;
        
    } else {
        NSInteger selectedCityIndex = [_citySelector selectedRowInComponent:0];
        CityModel *seletedCityModel = [_cityarr objectAtIndex:selectedCityIndex];
        _cityId = seletedCityModel.id;
        
        CityModel *seletedLocationModel = [_locationArr objectAtIndex:row];
        _locationId = seletedLocationModel.id;
    }
}


- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (UIImage *)getScaleBackUIImage:(NSString*)name isFront:(BOOL)isFront{
    UIImage *bubble = [UIImage imageNamed:name];
    
    UIEdgeInsets capInsets;
    if (isFront) {
        capInsets = UIEdgeInsetsMake(0, 10, 0, 6);
    }else{
        capInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (IBAction)locationSel:(UIButton *)sender {
    [_locationSelImage setImage:[UIImage imageNamed:@"uyoung.bundle/up_arrow"]];
    [_selectedButton setHidden:NO];
    [_cancelButton setHidden:NO];
    [_citySelector setHidden:NO];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 选择头像
- (IBAction)changeHeader:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _camera = [[UIImagePickerController alloc] init];
        _camera.delegate = self;
        _camera.allowsEditing = YES;
        _camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //此处设置只能使用相机，禁止使用视频功能
        _camera.mediaTypes = @[(NSString*)kUTTypeImage];

        [self presentViewController:_camera animated:YES completion:nil];
    }
}

- (IBAction)textfieldEditingChanged:(UITextField *)sender {
    NSInteger tag = sender.tag;
    NSInteger textLength = 10;
    if (tag==1006) {
        return;
    }
    if (tag==1002||tag==1005) {
        textLength = 20;
    } else if(tag==1004){
        textLength = 11;
    }

    if (sender.text.length > textLength) {
        sender.text = [sender.text substringToIndex:textLength];
    }

}

//点击相册中的图片或照相机照完后点击use后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img;
    if ([info objectForKey:UIImagePickerControllerEditedImage]) {
        img = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    //更新图片
    [_userHeaderButton setBackgroundImage:img forState:UIControlStateNormal];
    
    //上传图片至七牛云
    [[UploadImageUtil dispatchOnce]uploadImage:img withKey:[NSString stringWithFormat:@"uyoung_header_%d", (int)_loginUser.id] delegate:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//用户取消回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)genderSel:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag==1) {//说明选择的是男
        UIButton *f = (UIButton*)[self.view viewWithTag:2];
        [f setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
    }else{//说明选择女
        UIButton *m = (UIButton*)[self.view viewWithTag:1];
        [m setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
    }
    _gender = tag;
}

#pragma mark 处理键盘遮挡
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave {
    UIView *accessoryView = textField.inputAccessoryView;
    UIView *inputview     = textField.inputView;
    
    int textFieldY = 0;
    int accessoryY = 0;
    if (accessoryView && inputview){
        CGRect accessoryRect = accessoryView.frame;
        CGRect inputViewRect = inputview.frame;
        accessoryY = 480 - (accessoryRect.size.height + inputViewRect.size.height);
    } else if (accessoryView) {
        CGRect accessoryRect = accessoryView.frame;
        accessoryY = 480 - (accessoryRect.size.height + 216);
    } else if (inputview) {
        CGRect inputViewRect = inputview.frame;
        accessoryY = 480 -inputViewRect.size.height;
    } else {
        accessoryY = 480 - 216; //480 - 216;
    }
    
    
    CGRect textFieldRect = textField.frame;
    textFieldY = textFieldRect.origin.y + textFieldRect.size.height;
    
    int offsetY = textFieldY - accessoryY;
    if (!leave && offsetY > 0) {
        int y_offset = -5;
        
        y_offset += -offsetY;
        
        CGRect viewFrame = self.view.frame;
        
        viewFrame.origin.y += y_offset;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    } else {
        CGRect viewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }

}

- (void)moveView:(UITextField *)textField{
    CGRect textFieldRect = textField.frame;
    _textFieldY = textFieldRect.origin.y + textFieldRect.size.height + 20;
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self moveView:textField leaveView:NO];
//    [self moveView:textField];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField{
     [self moveView:textField leaveView:YES];
}

//更新用户数据
- (IBAction)updateUser:(UIButton *)sender {
    NSDictionary *userData = [[NSMutableDictionary alloc]initWithCapacity:5];
    NSString *nickName = _nicknameInput.text;
    NSString *avater = _avater;
    NSString *company = _companyInput.text;
    NSString *position = _positionInput.text;
    NSString *email = _emailInput.text;
    NSString *cellphone = _mobileInput.text;
    NSString *equips = _equipmentInput.text;
    [userData setValue:nickName forKey:@"nickName"];
    [userData setValue:@(_gender) forKey:@"gender"];
    if ([NSString isBlankString:avater]==YES) {
        avater = _loginUser.avatarUrl;
    }
    [userData setValue:avater forKey:@"avatarUrl"];
    [userData setValue:email forKey:@"email"];
    [userData setValue:cellphone forKey:@"phone"];
    [userData setValue:[NSString stringWithFormat:@"%d-%d", (int)_cityId, (int)_locationId] forKey:@"address"];
    [userData setValue:company forKey:@"company"];
    [userData setValue:position forKey:@"position"];
    [userData setValue:equips forKey:@"equipment"];
    [userData setValue:@(_loginUser.id) forKey:@"id"];
    [self.view.window showHUDWithText:@"正在更新" Type:ShowLoading Enabled:YES];
    [UpdateUser updateUserWithDictionary:userData delegate:self];
}

- (void)didUpdateEnd:(BOOL)isSuccess{
    if (isSuccess) {
        [self.view.window showHUDWithText:@"保存成功" Type:ShowPhotoYes Enabled:YES];
        //从新获取用户数据，进行保存
        [UserDetail getUserDetailWithId:_loginUser.id delegate:self];
    } else{
        [self.view.window showHUDWithText:@"保存失败" Type:ShowPhotoNo Enabled:YES];
    }
}

//保存更新本地用户数据
- (void)fillUserDetail:(NSDictionary*)dict{
    UserDetailModel *userDetailModel = [MTLJSONAdapter modelOfClass:[UserDetailModel class] fromJSONDictionary:dict error:nil];
    [userDetailModel save];
    _loginUser = [userDetailModel copy];
    [self initUser];
}

//获得七牛云存储的头像的url
- (void)getImgUrl:(NSString*)url{
    long timer = [[NSDate date] timeIntervalSince1970];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?%ld", timer]];
    _avater = url;
}

//计算键盘的高度
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}

-(void)keyboardWillAppear:(NSNotification *)notification{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];//键盘高度
    CGFloat keyboardY = 480 - change;//获得键盘遮挡位置的Y值
    if (_isKeyboardHidden==NO) {//说明已经有位移
        currentFrame.origin.y = currentFrame.origin.y - _offset;
    }
    if(keyboardY < _textFieldY){//说明被挡住
        _offset = keyboardY - _textFieldY;
        currentFrame.origin.y = _offset ;//计算偏移量
    }
    self.view.frame = currentFrame;
    _isKeyboardHidden = NO;
}

-(void)keyboardWillDisappear:(NSNotification *)notification{
    self.view.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
    _isKeyboardHidden = YES;
}

@end
