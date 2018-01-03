#import "VENMoneyCalculator.h"
#import "NSString+VENCalculatorInputView.h"

@interface VENMoneyCalculator ()
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@end

@implementation VENMoneyCalculator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locale = [NSLocale autoupdatingCurrentLocale];
    }
    return self;
}

- (NSString *)evaluateExpression:(NSString *)expressionString {
    if (!expressionString) {
        return nil;
    }
    NSString *floatString = [NSString stringWithFormat:@"1.0*%@", expressionString];
    NSString *sanitizedString = [self sanitizedString:floatString];
    NSExpression *expression;
    id result;
    @try {
        expression = [NSExpression expressionWithFormat:sanitizedString];
        result = [expression expressionValueWithObject:nil context:nil];
    }
    @catch (NSException *exception) {
        if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
            return nil;
        } else {
            [exception raise];
        }
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        NSInteger integerExpression = [(NSNumber *)result integerValue];
        CGFloat floatExpression = [(NSNumber *)result floatValue];
        if (integerExpression == floatExpression) {
            return [(NSNumber *)result stringValue];
        } else if (floatExpression >= CGFLOAT_MAX || fabs(floatExpression) <= CGFLOAT_MIN || isnan(floatExpression) || isinf(floatExpression)) {
            return @"0";
        } else {
            NSString *moneyFormattedNumber = [[self numberFormatter] stringFromNumber:@(floatExpression)];
            return [moneyFormattedNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    } else {
        return nil;
    }
}


#pragma mark - Private

- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        [_numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_numberFormatter setCurrencySymbol:@""];
        [_numberFormatter setCurrencyDecimalSeparator:[self decimalSeparator]];
        _numberFormatter.currencyGroupingSeparator = @"";
    }
    return _numberFormatter;
}

- (NSString *)sanitizedString:(NSString *)string {
    return [[self replaceOperandsInString:string] stringByReplacingCharactersInSet:[self illegalCharacters] withString:@""];
}

- (NSString *)replaceOperandsInString:(NSString *)string {
    NSString *subtractReplaced = [string stringByReplacingOccurrencesOfString:@"−" withString:@"-"];
    NSString *divideReplaced = [subtractReplaced stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    NSString *multiplyReplaced = [divideReplaced stringByReplacingOccurrencesOfString:@"×" withString:@"*"];

    return [multiplyReplaced stringByReplacingOccurrencesOfString:[self decimalSeparator] withString:@"."];
}

- (NSCharacterSet *)illegalCharacters {
    return [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-/*.+"] invertedSet];
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

@end
