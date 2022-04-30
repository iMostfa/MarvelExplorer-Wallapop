//
//  PosterImageRepository.swift
//  MarvelExplorer
//
//  Created by Mostfa on 30/04/2022.
//

import Foundation
import Combine

protocol PosterImageRepository { func fetchImage(with path: String) -> AnyPublisher<Date?,Never> }
