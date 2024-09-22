//  SecondTableViewCell.m
//  RSSReader
//
//  Created by Nachiket Shilwant on 23/08/24.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell
@synthesize imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc] init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _firstLabel = [[UILabel alloc] init];
        [_firstLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
        _firstLabel.numberOfLines = 0;
        _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _secondLabel = [[UILabel alloc] init];
        [_secondLabel setFont:[UIFont systemFontOfSize:18]];
        _secondLabel.numberOfLines = 0;

        _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:_firstLabel];
        [self.contentView addSubview:_secondLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
            [imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
            [imageView.widthAnchor constraintEqualToConstant:80],
            [imageView.heightAnchor constraintEqualToConstant:80],
            
            [_firstLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
            [_firstLabel.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:10],
            [_firstLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
            
            [_secondLabel.topAnchor constraintEqualToAnchor:_firstLabel.bottomAnchor constant:5],
            [_secondLabel.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:10],
            [_secondLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10],
            [_secondLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10]
        ]];
        
    }
    return self;
}

@end
