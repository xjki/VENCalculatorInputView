#import <UIKit/UIKit.h>

@class VENCalculatorInputView;
@protocol VENCalculatorInputViewDelegate <NSObject>

@optional
- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key;
- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView;
- (void)calculatorInputViewDidTapClear:(VENCalculatorInputView *)calculatorInputView;
- (void)calculatorInputViewDidTapEquals:(VENCalculatorInputView *)calculatorInputView;
- (void)calculatorInputViewDidTapChangeSign:(VENCalculatorInputView *)calculatorInputView;

@end

@interface VENCalculatorInputView : UIView <UIInputViewAudioFeedback>

/// Keyboard style for input view
typedef NS_ENUM(NSInteger, VENCalculatorInputViewStyle) {
    /// Default keyboard
	VENCalculatorInputViewStyleDefault = 0,
    /// Keyboard with Clear and Equals buttons
	VENCalculatorInputViewStyleWithEquals = 1
};

@property (weak, nonatomic) id<VENCalculatorInputViewDelegate> delegate;

/**-----------------------------------------------------------------------------
 * @name Localization
 * -----------------------------------------------------------------------------
 */

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (strong, nonatomic) NSLocale *locale;


/**-----------------------------------------------------------------------------
 * @name Customizing colors
 * -----------------------------------------------------------------------------
 */

@property (strong, nonatomic) UIColor *buttonTitleColor;
@property (strong, nonatomic) UIFont  *buttonTitleFont;
@property (strong, nonatomic) UIColor *buttonHighlightedColor;

@property (strong, nonatomic) UIColor *numberButtonBackgroundColor;
@property (strong, nonatomic) UIColor *numberButtonBorderColor;

@property (strong, nonatomic) UIColor *operationButtonBackgroundColor;
@property (strong, nonatomic) UIColor *operationButtonBorderColor;

@property (strong, nonatomic) UIColor *equalsButtonBackgroundColor;
@property (strong, nonatomic) UIColor *changeSignButtonBackgroundColor;
@property (strong, nonatomic) UIColor *decimalButtonBackgroundColor;

/**
 * Inits keyboard view with selected style
 * @param style     style of the keyboard (with or without extra buttons)
 * @return Instance or nil.
 */
- (instancetype)initWithStyle:(VENCalculatorInputViewStyle)style;

@end
