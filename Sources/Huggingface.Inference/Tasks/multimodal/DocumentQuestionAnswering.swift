//
//  DocumentQuestionAnswering.swift
//

import Foundation

struct DocumentQuestionAnsweringInputs: Codable {
	let image: String
	let question: String
}

public struct DocumentQuestionAnsweringOutput: Codable {
	/**
	 * A string that’s the answer within the document.
	 */
	let answer: String?
	let start: Int?
	let end: Int?
	/**
	 * A float that represents how likely that the answer is correct
	 */
	let score: Float?
	
}

extension HfInference {
	public func documentQuestionAnswering(
		image: Data,
		question: String,
		model: String? = nil,
		options: HfInferenceOptions = .init()
	) async throws -> [DocumentQuestionAnsweringOutput] {
		return try await execute(
			model: model,
			taskHint: .documentQuestionAnswering,
			body: DocumentQuestionAnsweringInputs(
				image: image.base64EncodedString(),
				question: question
			),
			requestType: .json,
			responseType: .json,
			options: options
		)
	}
}
