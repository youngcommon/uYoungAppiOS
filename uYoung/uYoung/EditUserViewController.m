//
//  EditUserViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EditUserViewController.h"

@interface EditUserViewController ()

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backCoverImageView.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    [_locationSelButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_locationSelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self initPicker];
    [self updateConstraints];
    
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
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"provinces_cities" ofType:@"plist"];
    _citydict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _provinceArr = [_citydict allKeys];
    
    NSInteger selectedProvinceIndex = [_citySelector selectedRowInComponent:0];
    NSString *seletedProvince = [_provinceArr objectAtIndex:selectedProvinceIndex];
    _cityArr = [_citydict objectForKey:seletedProvince];
    
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
    NSInteger rowProvince = [_citySelector selectedRowInComponent:0];
    NSString *province = [_provinceArr objectAtIndex:rowProvince];
    
    NSInteger rowCity = [_citySelector selectedRowInComponent:1];
    NSString *city = [_cityArr objectAtIndex:rowCity];
    
    [_locationSelButton setTitle:[NSString stringWithFormat:@"%@ - %@", province, city] forState:UIControlStateNormal];
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
    if (component == 0) {//省份个数
        return [_provinceArr count];
    } else {//市的个数
        return [_cityArr count];
    }
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择省份名
        return [_provinceArr objectAtIndex:row];
    } else {//选择市名
        return [_cityArr objectAtIndex:row];
    }
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *seletedProvince = [_provinceArr objectAtIndex:row];
        _cityArr = [_citydict objectForKey:seletedProvince];
        
        //重点！更新第二个轮子的数据
        [_citySelector reloadComponent:1];
        
        NSInteger selectedCityIndex = [_citySelector selectedRowInComponent:1];
        NSString *seletedCity = [_cityArr objectAtIndex:selectedCityIndex];
        
        NSString *msg = [NSString stringWithFormat:@"province=%@,city=%@", seletedProvince,seletedCity];
        NSLog(@"%@",msg);
    } else {
        NSInteger selectedProvinceIndex = [_citySelector selectedRowInComponent:0];
        NSString *seletedProvince = [_provinceArr objectAtIndex:selectedProvinceIndex];
        
        NSString *seletedCity = [_cityArr objectAtIndex:row];
        NSString *msg = [NSString stringWithFormat:@"province=%@,city=%@", seletedProvince,seletedCity];
        NSLog(@"%@",msg);
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

//点击相册中的图片或照相机照完后点击use后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img;
    if ([info objectForKey:UIImagePickerControllerEditedImage]) {
        img = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    [_userHeaderButton setBackgroundImage:img forState:UIControlStateNormal];
    
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
@end