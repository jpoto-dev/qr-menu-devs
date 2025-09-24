<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class DocumentsController extends AbstractController
{
    public function index(ManagerRegistry $doctrine): Response
    {
        $conn = $doctrine->getConnection();

        // Execute bf_nc_o.sql
        $sqlFile1 = __DIR__ . '/../../queries/bf_nc_o.sql';
        $sql1 = file_get_contents($sqlFile1);
        $result1 = $conn->executeQuery($sql1, [
            'tiendas' => [949, 947],
            'fecha_inicio' => '2025-08-01 00:00:00.000',
            'fecha_fin' => '2025-09-01 00:00:00.000'
        ], [
            'tiendas' => Connection::PARAM_INT_ARRAY
        ]);
        $bfNcO = $result1->fetchAllAssociative();

        // Execute bf_o.sql
        $sqlFile2 = __DIR__ . '/../../queries/bf_o.sql';
        $sql2 = file_get_contents($sqlFile2);
        $result2 = $conn->executeQuery($sql2, [
            'tiendas' => [949, 947],
            'fecha_inicio' => '2025-08-01 00:00:00.000',
            'fecha_fin' => '2025-09-01 00:00:00.000'
        ], [
            'tiendas' => Connection::PARAM_INT_ARRAY
        ]);
        $bfO = $result2->fetchAllAssociative();

        return $this->render('documents/index.html.twig', [
            'bf_nc_o' => $bfNcO,
            'bf_o' => $bfO
        ]);
    }
}