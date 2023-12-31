/**
 * Tencent is pleased to support the open source community by making QMUI_iOS available.
 * Copyright (C) 2016-2021 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */
//
//  QMUIBarProtocolPrivate.m
//  QMUIKit
//
//  Created by molice on 2022/5/18.
//

#import "QMUIBarProtocolPrivate.h"
#import "QMUIBarProtocol.h"
#import "QMUICore.h"

@implementation QMUIBarProtocolPrivate

+ (void)swizzleBarBackgroundViewIfNeeded {
    [QMUIHelper executeBlock:^{
        Class backgroundClass = NSClassFromString(@"_UIBarBackground");
        
        OverrideImplementation(backgroundClass, @selector(didMoveToSuperview), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject) {
                
                // call super
                void (*originSelectorIMP)(id, SEL);
                originSelectorIMP = (void (*)(id, SEL))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD);
                
                if ([selfObject.superview conformsToProtocol:@protocol(QMUIBarProtocol)]) {
                    id<QMUIBarProtocolPrivate> bar = (id<QMUIBarProtocolPrivate>)selfObject.superview;
                    if (bar.qmuibar_hasSetEffect || bar.qmuibar_hasSetEffectForegroundColor) {
                        [bar qmuibar_updateEffect];
                    }
                }
            };
        });
        
        OverrideImplementation(backgroundClass, @selector(didAddSubview:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIView *selfObject, UIView *subview) {
                
                // call super
                void (*originSelectorIMP)(id, SEL, UIView *);
                originSelectorIMP = (void (*)(id, SEL, UIView *))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, subview);
                
                // 注意可能存在多个 UIVisualEffectView，例如用于 shadowImage 的 _UIBarBackgroundShadowView，需要过滤掉
                if ([subview isMemberOfClass:UIVisualEffectView.class]
                    && [selfObject.superview conformsToProtocol:@protocol(QMUIBarProtocol)]) {
                    id<QMUIBarProtocolPrivate> bar = (id<QMUIBarProtocolPrivate>)selfObject.superview;
                    if (bar.qmuibar_hasSetEffect || bar.qmuibar_hasSetEffectForegroundColor) {
                        [bar qmuibar_updateEffect];
                    }
                }
            };
        });
        
        // 系统会在任意可能的时机去刷新 backgroundEffects，为了避免被系统的值覆盖，这里需要重写它
        OverrideImplementation(UIVisualEffectView.class, NSSelectorFromString(@"setBackgroundEffects:"), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^(UIVisualEffectView *selfObject, NSArray<UIVisualEffect *> *firstArgv) {
                
                if ([selfObject.superview isKindOfClass:backgroundClass]
                    && [selfObject.superview.superview conformsToProtocol:@protocol(QMUIBarProtocol)]) {
                    id<QMUIBarProtocol, QMUIBarProtocolPrivate> bar = (id<QMUIBarProtocol, QMUIBarProtocolPrivate>)selfObject.superview.superview;
                    if (bar.qmui_effectView == selfObject) {
                        if (bar.qmuibar_hasSetEffect) {
                            firstArgv = bar.qmuibar_backgroundEffects;
                        }
                    }
                }
                
                // call super
                void (*originSelectorIMP)(id, SEL, NSArray<UIVisualEffect *> *);
                originSelectorIMP = (void (*)(id, SEL, NSArray<UIVisualEffect *> *))originalIMPProvider();
                originSelectorIMP(selfObject, originCMD, firstArgv);
            };
        });
    } oncePerIdentifier:@"QMUIBarProtocolPrivate"];
}

@end
