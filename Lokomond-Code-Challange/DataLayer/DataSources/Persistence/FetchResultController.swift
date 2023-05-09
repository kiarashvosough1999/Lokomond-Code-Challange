//
//  FetchResultController.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import CoreData
import Combine

internal final class FetchResultController<E: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
    
    private let resultSubject: PassthroughSubject<[E], Never>
    private let controller: NSFetchedResultsController<E>

    init(request: NSFetchRequest<E>, managedObjectContext: NSManagedObjectContext) {
        self.resultSubject = PassthroughSubject<[E], Never>()
        self.controller = NSFetchedResultsController<E>(
            fetchRequest: request,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

    }

    // MARK: - NSFetchedResultsControllerDelegate

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObject = controller.fetchedObjects as? [E] else { return }
        resultSubject.send(fetchedObject)
    }

    // MARK: - APIs

    public func start() throws {
        controller.delegate = self
        try controller.performFetch()
    }

    public var resultPublisher: AnyPublisher<[E], Never> {
        resultSubject.eraseToAnyPublisher()
    }
}
