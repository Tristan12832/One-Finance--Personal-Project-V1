//
//  FormatStyle-LocalCurrency.swift
//  One Finance
//
//  Created by Tristan Stenuit on 26/08/2023.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}
