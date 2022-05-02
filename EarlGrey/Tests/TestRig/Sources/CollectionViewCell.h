//
// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <UIKit/UIKit.h>

// CollectionViewCell implements a button with an alphabet as text that turns into the alphabet's
// ASCII value ('A' - 65, 'B' - 66 etc) when tapped.
@interface CollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) IBOutlet UIButton *alphaButton;
@end
