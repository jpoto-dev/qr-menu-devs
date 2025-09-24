<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class DocumentsController extends AbstractController
{
    public function number(ManagerRegistry $doctrine): Response
    {
        $conn = $doctrine->getConnection();
        $sqlFile = __DIR__ . '/../../queries/bf_nc_o.sql';
        $sql = file_get_contents($sqlFile);
        $result = $conn->executeQuery($sql, [
            'tiendas' => [949, 947],
            'fecha_inicio' => '2025-08-01 00:00:00.000',
            'fecha_fin' => '2025-09-01 00:00:00.000'
        ], [
            'tiendas' => Connection::PARAM_INT_ARRAY
        ]);
        $results = $result->fetchAllAssociative();

        return $this->render('documents/number.html.twig', [
            'documents' => $results
        ]);
    }
}