//
//  FetchResultController.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import CoreData
import Combine

internal protocol FetchResultControllerProtocol: AnyObject {
    func cancel()
    func start() throws
}

internal final class FetchResultController<E: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate, FetchResultControllerProtocol {
    
    private let resultSubject: CurrentValueSubject<[E], Never>
    private var controller: NSFetchedResultsController<E>?

    init(request: NSFetchRequest<E>, managedObjectContext: NSManagedObjectContext) {
        self.resultSubject = CurrentValueSubject<[E], Never>([])
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

    internal func start() throws {
        controller?.delegate = self
        try controller?.performFetch()
        guard
            let fetchedObjects = controller?.fetchedObjects,
                fetchedObjects.isEmpty == false
        else { return }
        resultSubject.send(fetchedObjects)
    }

    func cancel() {
        controller = nil
        resultSubject.send(completion: .finished)
    }

    internal var resultPublisher: AnyPublisher<[E], Never> {
        resultSubject.eraseToAnyPublisher()
    }
}
