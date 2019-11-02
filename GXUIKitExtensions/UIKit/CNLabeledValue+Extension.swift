//
//  CNLabeledValue+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 8/20/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import Contacts

extension CNLabeledValue where ValueType == CNPhoneNumber {
    public var plainLabelString: String? {
        guard let labelString = self.label else { return nil }
        if labelString.count > 0 {
            return CNLabeledValueLabelToPlainString(labelString) ??  labelString
        }
        return labelString
    }
}


extension CNLabeledValue where ValueType == NSString {
    public var plainLabelString: String? {
        guard let labelString = self.label else { return nil }
        if labelString.count > 0 {
            return CNLabeledValueLabelToPlainString(labelString) ??  labelString
        }
        return labelString
    }
}

extension CNLabeledValue where ValueType == NSDateComponents {
    public var plainLabelString: String? {
        guard let labelString = self.label else { return nil }
        if labelString.count > 0 {
            return CNLabeledValueLabelToPlainString(labelString) ??  labelString
        }
        return labelString
    }
}



//CNPostalAddress
extension CNLabeledValue where ValueType == CNPostalAddress {
    public var plainLabelString: String? {
        guard let labelString = self.label else { return nil }
        if labelString.count > 0 {
            return CNLabeledValueLabelToPlainString(labelString) ??  labelString
        }
        return labelString
    }
}

func CNLabeledValueLabelToPlainString(_ labelString:String ) -> String?  {
    if labelString == CNLabelHome {
        return "CNLabelHome";
    } else if labelString == CNLabelWork {
        return "CNLabelWork";
    } else if labelString == CNLabelOther {
        return "CNLabelOther";
    }else if labelString == CNLabelEmailiCloud {
        return "CNLabelEmailiCloud";
    }else if labelString == CNLabelURLAddressHomePage {
        return "CNLabelURLAddressHomePage";
    }else if labelString == CNLabelDateAnniversary {
        return "CNLabelDateAnniversary";
    }
    
    else if labelString == CNLabelPhoneNumberMain {
        return "CNLabelPhoneNumberMain";
    }else if labelString == CNLabelPhoneNumberiPhone {
        return "CNLabelPhoneNumberiPhone";
    }else if labelString == CNLabelPhoneNumberMobile{
        return "CNLabelPhoneNumberMobile";
    }else if labelString == CNLabelPhoneNumberPager {
        return "CNLabelPhoneNumberPager";
    }else if labelString == CNLabelPhoneNumberWorkFax {
        return "CNLabelPhoneNumberWorkFax";
    }else if labelString == CNLabelPhoneNumberHomeFax {
        return "CNLabelPhoneNumberHomeFax";
    }else if labelString == CNLabelPhoneNumberOtherFax {
        return "CNLabelPhoneNumberOtherFax";
    }else if labelString == CNLabelContactRelationSpouse {
        return "CNLabelContactRelationSpouse";
    }else if labelString == CNLabelContactRelationPartner {
        return "CNLabelContactRelationPartner";
    }
    
    
    else if labelString == CNLabelContactRelationChild {
        return "CNLabelContactRelationChild";
    }
    else if labelString == CNLabelContactRelationParent {
        return "CNLabelContactRelationParent";
    }
    else if labelString == CNLabelContactRelationFather {
        return "CNLabelContactRelationFather";
    }
    else if labelString == CNLabelContactRelationMother {
        return "CNLabelContactRelationMother";
    }
    else if labelString == CNLabelContactRelationSister {
        return "CNLabelContactRelationSister";
    }
    else if labelString == CNLabelContactRelationBrother {
        return "CNLabelContactRelationBrother";
    }
    else if labelString == CNLabelContactRelationFriend {
        return "CNLabelContactRelationFriend";
    }
    else if labelString == CNLabelContactRelationManager {
        return "CNLabelContactRelationManager";
    }else if labelString == CNLabelContactRelationAssistant {
        return "CNLabelContactRelationAssistant";
    }
    
    if #available(iOS 11, *) {
        if labelString == CNLabelContactRelationDaughter {
            return "CNLabelContactRelationDaughter";
        }
        
        else if labelString == CNLabelContactRelationSon {
            return "CNLabelContactRelationSon";
        }
    }
    if #available(iOS 13.0, *){
        if labelString == CNLabelContactRelationColleague {
            return "CNLabelContactRelationColleague";
        }else if labelString == CNLabelContactRelationTeacher {
            return "CNLabelContactRelationTeacher";
        }
        else if labelString == CNLabelContactRelationSibling {
            return "CNLabelContactRelationSibling";
        }
        else if labelString == CNLabelContactRelationYoungerSibling {
            return "CNLabelContactRelationYoungerSibling";
        }
        else if labelString == CNLabelContactRelationElderSister {
            return "CNLabelContactRelationElderSister";
        }
        else if labelString == CNLabelContactRelationYoungerSister {
            return "CNLabelContactRelationYoungerSister";
        }
        else if labelString == CNLabelContactRelationYoungestSister {
            return "CNLabelContactRelationYoungestSister";
        }
        else if labelString == CNLabelContactRelationWife {
            return "CNLabelContactRelationWife";
        }
        else if labelString == CNLabelContactRelationHusband {
            return "CNLabelContactRelationHusband";
        } else if labelString == CNLabelSchool {
            return "CNLabelSchool";
        }
    }
    
    if labelString == "_$!<Car>!$_" {
        return "Car"
    } else if labelString == "_$!<Radio>!$_" {
        return "Radio"
    }
    if labelString.hasPrefix("_$") {
        LOGE("Unknown CNLabeledValue label :\(labelString)  count:\(labelString.count)")
    }
    return nil
}
