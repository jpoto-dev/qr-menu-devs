<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class DocumentsController extends AbstractController
{
    public function index(Request $request, ManagerRegistry $doctrine): Response
    {
        $tiendasStr = $request->query->get('tiendas', '949,947');
        $tiendas = array_map('intval', array_map('trim', explode(',', $tiendasStr)));
        $fechaInicioStr = $request->query->get('fecha_inicio', '2025-08-01');
        $fechaFinStr = $request->query->get('fecha_fin', '2025-09-01');
        $fechaInicio = $fechaInicioStr . ' 00:00:00.000';
        $fechaFinDate = new \DateTime($fechaFinStr);
        $fechaFinDate->modify('+1 day');
        $fechaFin = $fechaFinDate->format('Y-m-d') . ' 00:00:00.000';

        $conn = $doctrine->getConnection();

        // Execute bf_nc_o.sql
        $sqlFile1 = __DIR__ . '/../../queries/bf_nc_o.sql';
        $sql1 = file_get_contents($sqlFile1);
        $result1 = $conn->executeQuery($sql1, [
            'tiendas' => $tiendas,
            'fecha_inicio' => $fechaInicio,
            'fecha_fin' => $fechaFin
        ], [
            'tiendas' => Connection::PARAM_INT_ARRAY
        ]);
        $bfNcO = $result1->fetchAllAssociative();

        // Execute bf_o.sql
        $sqlFile2 = __DIR__ . '/../../queries/bf_o.sql';
        $sql2 = file_get_contents($sqlFile2);
        $result2 = $conn->executeQuery($sql2, [
            'tiendas' => $tiendas,
            'fecha_inicio' => $fechaInicio,
            'fecha_fin' => $fechaFin
        ], [
            'tiendas' => Connection::PARAM_INT_ARRAY
        ]);
        $bfO = $result2->fetchAllAssociative();

        return $this->render('documents/index.html.twig', [
            'bf_nc_o' => $bfNcO,
            'bf_o' => $bfO,
            'current_tiendas' => implode(',', $tiendas),
            'current_fecha_inicio' => $fechaInicioStr,
            'current_fecha_fin' => $fechaFinStr
        ]);
    }
}