//
//  LSP_CertificationTests.swift
//  LSP CertificationTests
//
//  Created by Edward Suwandi on 09/01/26.
//

import Testing
@testable import LSP_Certification

struct LSP_CertificationTests {

    var viewModel = CatalogViewModel()

    @Test
    func testLoadBooks() async throws {
        await viewModel.loadBooks()
        #expect(!viewModel.books.isEmpty, "Books should be loaded from Supabase")
    }

}
