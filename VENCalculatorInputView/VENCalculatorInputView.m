#import "VENCalculatorInputView.h"

@interface VENCalculatorInputView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtonCollection;
@property (strong, nonatomic) IBOutlet UIButton *decimalButton;
@property (strong, nonatomic) IBOutlet UIButton *backspaceButton;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation VENCalculatorInputView

+ (NSBundle *)bundle {
    NSBundle *bundle = [NSBundle bundleForClass:[VENCalculatorInputView class]];
    return bundle;
}

- (instancetype)initWithStyle:(VENCalculatorInputViewStyle)style {
    switch (style) {
        case VENCalculatorInputViewStyleDefault:
            return [self initWithNibNamed:@"VENCalculatorInputView"];
            break;

        case VENCalculatorInputViewStyleWithEquals:
            return [self initWithNibNamed:@"VENCalculatorInputViewWithEqual"];
            break;
    }
}

- (instancetype)initWithNibNamed:(NSString*)nibName {
    self = [[[VENCalculatorInputView bundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [[[VENCalculatorInputView bundle] loadNibNamed:@"VENCalculatorInputView" owner:self options:nil] firstObject];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    // Set default locale
    self.locale = [NSLocale autoupdatingCurrentLocale];

    // Set customizable properties
    [self setNumberButtonBackgroundColor:[UIColor colorWithWhite:0.98828 alpha:1]];
    [self setNumberButtonBorderColor:[UIColor colorWithRed:193/255.0f green:195/255.0f blue:199/255.0f alpha:1]];
    [self setOperationButtonBackgroundColor:[UIColor colorWithRed:193/255.0f green:196/255.0f blue:200/255.0f alpha:1]];
    [self setOperationButtonBorderColor:[UIColor colorWithRed:172/255.0f green:174/255.0f blue:177/255.0f alpha:1]];
    [self setButtonHighlightedColor:[UIColor grayColor]];
    [self setButtonTitleColor:[UIColor darkTextColor]];

    // Set default properties
    for (UIButton *numberButton in self.numberButtonCollection) {
        [self setupButton:numberButton];
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        [self setupButton:operationButton];
    }
    [self.backspaceButton setImage:[self backspaceImage] forState:UIControlStateNormal];
}

- (UIImage *) backspaceImage {
    // set up a graphics context of image size
    CGRect frame = CGRectMake(0, 0, 22, 15);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Bezier 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0f, 0.0f);
    CGContextScaleCTM(context, 1.0f, 1.0f);

    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(0.5, 7.5)];
    [bezierPath addLineToPoint: CGPointMake(7.5, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(20.5, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(21.5, 1.5)];
    [bezierPath addLineToPoint: CGPointMake(21.5, 13.5)];
    [bezierPath addLineToPoint: CGPointMake(20.5, 14.5)];
    [bezierPath addLineToPoint: CGPointMake(7.5, 14.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 7.5)];
    [bezierPath closePath];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(17.5, 3.5)];
    [bezier2Path addCurveToPoint: CGPointMake(9.5, 11.5) controlPoint1: CGPointMake(9.5, 11.5) controlPoint2: CGPointMake(9.5, 11.5)];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
    [bezier3Path moveToPoint: CGPointMake(17.5, 11.5)];
    [bezier3Path addLineToPoint: CGPointMake(9.5, 3.5)];
    [UIColor.blackColor setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
    
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    NSString *decimalSymbol = [locale objectForKey:NSLocaleDecimalSeparator];
    [self.decimalButton setTitle:decimalSymbol forState:UIControlStateNormal];
}

- (void)setupButton:(UIButton *)button {
    button.layer.borderWidth = 0.25f;
}

- (IBAction)userDidTapBackspace:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputViewDidTapBackspace:)]) {
        [self.delegate calculatorInputViewDidTapBackspace:self];
    }
}

- (IBAction)userDidTapClear:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputViewDidTapClear:)]) {
        [self.delegate calculatorInputViewDidTapClear:self];
    }
}

- (IBAction)userDidTapChangeSign:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputViewDidTapChangeSign:)]) {
        [self.delegate calculatorInputViewDidTapChangeSign:self];
    }
}

- (IBAction)userDidTapEquals:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputViewDidTapEquals:)]) {
        [self.delegate calculatorInputViewDidTapEquals:self];
    }
}

- (IBAction)userDidTapKey:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    if ([self.delegate respondsToSelector:@selector(calculatorInputView:didTapKey:)]) {
        [self.delegate calculatorInputView:self didTapKey:sender.titleLabel.text];
    }
}


#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}


#pragma mark - Helpers

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [color set];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - Properties

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    _buttonTitleColor = buttonTitleColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        [numberButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        [operationButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    _buttonTitleFont = buttonTitleFont;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.titleLabel.font = buttonTitleFont;
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.titleLabel.font = buttonTitleFont;
    }
}

- (void)setButtonHighlightedColor:(UIColor *)buttonHighlightedColor {
    _buttonHighlightedColor = buttonHighlightedColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        [numberButton setBackgroundImage:[self imageWithColor:buttonHighlightedColor size:CGSizeMake(50, 50)]
                                forState:UIControlStateHighlighted];
    }
    for (UIButton *operationButton in self.operationButtonCollection) {
        [operationButton setBackgroundImage:[self imageWithColor:buttonHighlightedColor size:CGSizeMake(50, 50)]
                                   forState:UIControlStateHighlighted];
    }
}

- (void)setNumberButtonBackgroundColor:(UIColor *)numberButtonBackgroundColor {
    _numberButtonBackgroundColor = numberButtonBackgroundColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.backgroundColor = numberButtonBackgroundColor;
    }
}

- (void)setNumberButtonBorderColor:(UIColor *)numberButtonBorderColor {
    _numberButtonBorderColor = numberButtonBorderColor;
    for (UIButton *numberButton in self.numberButtonCollection) {
        numberButton.layer.borderColor = numberButtonBorderColor.CGColor;
    }
}

- (void)setOperationButtonBackgroundColor:(UIColor *)operationButtonBackgroundColor {
    _operationButtonBackgroundColor = operationButtonBackgroundColor;
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.backgroundColor = operationButtonBackgroundColor;
    }
}

- (void)setOperationButtonBorderColor:(UIColor *)operationButtonBorderColor {
    _operationButtonBorderColor = operationButtonBorderColor;
    for (UIButton *operationButton in self.operationButtonCollection) {
        operationButton.layer.borderColor = operationButtonBorderColor.CGColor;
    }
}

@end
