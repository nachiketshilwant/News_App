//
//  firstScreenTableViewCell.m
//  RSSReader
//
//  Created by Nachiket Shilwant on 23/08/24.
//

#import "firstScreenTableViewCell.h"

@implementation firstScreenTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _urlAdded = [[UIButton alloc] init];
        _urlAdded.translatesAutoresizingMaskIntoConstraints = NO;
        _urlAdded.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_urlAdded];
        
        [NSLayoutConstraint activateConstraints:@[
            [_urlAdded.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
            [_urlAdded.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
            [_urlAdded.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
            [_urlAdded.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10]
        ]];
    }
    return self;
}


@end
