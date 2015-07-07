//
//  ZSViewController.m
//  DragReaction
//
//  Created by Isaac Schmidt on 10/25/12.
//  Copyright (c) 2012 Zuse. All rights reserved.
//

#import "ZSViewController.h"
#import "UIGestureRecognizer+DraggingAdditions.h"
#import "polygonView.h"
@interface ZSViewController ()

@property (strong, nonatomic) NSArray *evaluateViews;

@property (strong, nonatomic) NSValue* dragViewStartFrame;
@property (strong, nonatomic) NSValue* dragViewStartFrame2;


@property (strong, nonatomic) UIView* draggingView2;

@property (strong, nonatomic) polygonView* polyView;
@end

@implementation ZSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *viewsOfInterest = @[self.oneView, self.twoView, self.threeView];
    [self setEvaluateViews:viewsOfInterest];
    self.dragViewStartFrame = [NSValue valueWithCGRect:self.draggingView.frame];
    
    self.draggingView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    self.draggingView2.backgroundColor= [UIColor grayColor];
    
     self.dragViewStartFrame2 = [NSValue valueWithCGRect:self.draggingView2.frame];
    
    self.draggingView.tag = 1;
    self.draggingView2.tag = 2;
    [self.view addSubview:self.draggingView2];
    
    UIPanGestureRecognizer* panReg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    
    [self.draggingView2 addGestureRecognizer:panReg];
    
    
    self.polyView = [[polygonView alloc] initWithFrame:CGRectMake(300, 300, 400, 400)];
    [self.view addSubview:self.polyView];
    self.polyView.backgroundColor = [UIColor redColor];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (IBAction)handlePanRecognizer:(id)sender
{
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        [[self completionLabel] setText:nil];
    }

    NSArray *views = [self evaluateViews];
    __block UILabel *label = [self completionLabel];
    
    // Block to execute when our dragged view is contained by one of our evaluation views.
    static void (^overlappingBlock)(UIView *overlappingView);
    
    overlappingBlock = ^(UIView *overlappingView) {
        
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIView *aView = (UIView *)obj;
            
            // Style an overlapping view
            if (aView == overlappingView)
            {
                aView.layer.borderWidth = 8.0f;
                aView.layer.borderColor = [[UIColor redColor] CGColor];
            }
            // Remove styling on non-overlapping views
            else
            {
                aView.layer.borderWidth = 0.0f;
            }
        }];
    };
    
   // Block to execute when gesture ends.
    
    __weak ZSViewController* weakself = self;
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        
        if (overlappingView)
        {
            NSUInteger overlapIndex = [[self evaluateViews] indexOfObject:overlappingView];
            NSString *completionText = [NSString stringWithFormat:@"Released over view at index: %d", overlapIndex];
            [label setText:completionText];
        }
        else{
        
            [UIView animateWithDuration:0.5 animations:^(){
                if (recongizer.view.tag==1) {
                    recongizer.view.frame = [weakself.dragViewStartFrame CGRectValue];

                }
                if (recongizer.view.tag==2) {
                    recongizer.view.frame=[weakself.dragViewStartFrame2 CGRectValue];
                }
            }];
            
        }
        
        
        
        // Remove styling from all views
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *aView = (UIView *)obj;
            aView.layer.borderWidth = 0.0f;
        }];
        
       
    };
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

@end
