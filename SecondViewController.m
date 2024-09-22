//  SecondViewController.m
//  RSSReader
//
//  Created by Nachiket Shilwant on 23/08/24.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "ThirdViewController.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupTableView];
    [self addDismissButton];
    [self fetchData];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"secondCell"];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-125]
    ]];
}

- (void)addDismissButton {
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.backgroundColor = UIColor.systemRedColor;
    [dismissButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [dismissButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:dismissButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [dismissButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [dismissButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [dismissButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [dismissButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fetchData {
    NSString *urlString = [NSString stringWithFormat:@"https://api.rss2json.com/v1/api.json?rss_url=%@", self.url];
    NSURL *urlToGet = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:urlToGet completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return;
        }
        
        if (data) {
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (jsonError) {
                NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                return;
            }
                        
            self.items = json[@"items"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    [dataTask resume];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    
    NSDictionary *item = self.items[indexPath.row];
    NSURL *url = [NSURL URLWithString:item[@"enclosure"][@"thumbnail"]];

    if (url) {
        NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error downloading image: %@", error.localizedDescription);
                return;
            }
            
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.imageView.image = image;
                    });
                } else {
                    NSLog(@"Error creating image from data");
                }
            }
        }];
        [downloadImageTask resume];
    } else {
        NSLog(@"Invalid URL: %@", item[@"enclosure"][@"thumbnail"]);
    }
    cell.firstLabel.text = item[@"title"];
    cell.secondLabel.text = item[@"description"];
    

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdViewController *pushVC = [[ThirdViewController alloc] init];
    pushVC.urlString = self.items[indexPath.row][@"link"];
    NSLog(@"%@", self.items[indexPath.row][@"link"]);
    pushVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:pushVC animated:true completion:nil];
}

@end
