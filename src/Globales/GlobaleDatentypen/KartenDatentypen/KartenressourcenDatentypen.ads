package KartenressourcenDatentypen is
   pragma Pure;
   
   type Ressourcen_Enum is (
                            Leer_Ressource_Enum,
                                   
                            -- Wasserressourcen
                            Fisch_Enum, Wal_Enum,
                            Hochwertiges_Holz_Enum,
                                   
                            -- Landressourcen
                            Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                     
                            -- Kernressourcen
                            
                           );
   pragma Ordered (Ressourcen_Enum);
   
   subtype Ressourcen_Vorhanden_Enum is Ressourcen_Enum range Ressourcen_Enum'Succ (Ressourcen_Enum'First) .. Ressourcen_Enum'Last;
   
   subtype Ressourcen_Oberfläche_Wasser_Enum is Ressourcen_Vorhanden_Enum range Fisch_Enum .. Wal_Enum;
   subtype Ressourcen_Oberfläche_Land_Enum is Ressourcen_Vorhanden_Enum range Hochwertiges_Holz_Enum .. Gold_Enum;
   
   subtype Ressourcen_Unterfläche_Wasser_Enum is Ressourcen_Vorhanden_Enum range Fisch_Enum .. Hochwertiges_Holz_Enum;
   subtype Ressourcen_Unterfläche_Land_Enum is Ressourcen_Vorhanden_Enum range Kohle_Enum .. Gold_Enum;
   
   -- Eihenfolge für die Ressourcen in den jeweiligen Bereichen: Pflanzen, Tiere, Mineralien, Sonstiges
   type Ressourcen_Neu_Enum is (
                                Leer_Ressourcen_Enum,
                                
                                -- Orbit
                                Asteroid_Enum,
                                
                                -- Himmel
                                Vogel_Enum,
                                
                                -- Oberfläche
                                Getreide_Enum, Mais_Enum, Kartoffeln_Enum, Sauerkraut_Enum, Weintrauben_Enum, Gewürze_Enum, Baumwolle_Enum, Tabak_Enum,
                                
                                Wildtiere_Enum,
                                
                                Kupfer_Enum, Eisen_Enum, Kohle_Enum, Silber_Enum, Gold_Enum,
                                
                                Öl_Enum, Salz_Enum, Zucker_Enum,
                                
                                -- Oberfläche Wasser
                                Fisch_Enum, Wal_Enum,
                                
                                -- Unterfläche
                                
                                
                                -- Unterfläche Wasser
                                Algen_Enum,
                                
                                Tiefenfisch_Enum
                                
                                -- Kern
                                
                               );
   pragma Ordered (Ressourcen_Neu_Enum);
   
   subtype Ressourcen_Neu_Vorhanden_Enum is Ressourcen_Neu_Enum range Ressourcen_Neu_Enum'Succ (Ressourcen_Neu_Enum'First) .. Ressourcen_Neu_Enum'Last;
   
   subtype Ressourcen_Orbit_Enum is Ressourcen_Neu_Vorhanden_Enum range Ressourcen_Neu_Vorhanden_Enum'First .. Asteroid_Enum;
   
   subtype Ressourcen_Himmel_Enum is Ressourcen_Neu_Vorhanden_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Orbit_Enum'Last) .. Vogel_Enum;
   
   subtype Ressourcen_Oberfläche_Enum is Ressourcen_Neu_Vorhanden_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Himmel_Enum'Last) .. Wal_Enum;
    subtype Ressourcen_Oberfläche_Land_Neu_Enum is Ressourcen_Oberfläche_Enum range Ressourcen_Oberfläche_Enum'First .. Zucker_Enum;
    subtype Ressourcen_Oberfläche_Wasser_Neu_Enum is Ressourcen_Oberfläche_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Oberfläche_Land_Neu_Enum'Last) .. Ressourcen_Oberfläche_Enum'Last;
   
   -- subtype Ressourcen_Unterfläche_Enum is Ressourcen_Neu_Vorhanden_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Oberfläche_Enum'Last) .. ;
   -- subtype Ressourcen_Unterfläche_Land_Neu_Enum is Ressourcen_Unterfläche_Enum range Ressourcen_Unterfläche_Enum'First .. Gold_Enum;
   -- subtype Ressourcen_Unterfläche_Wasser_Neu_Enum is Ressourcen_Unterfläche_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Unterfläche_Land_Neu_Enum'Last) .. Ressourcen_Unterfläche_Enum'Last;
   
   -- subtype Ressourcen_Kern_Enum is Ressourcen_Neu_Vorhanden_Enum range Ressourcen_Neu_Vorhanden_Enum'Succ (Ressourcen_Unterfläche_Enum'Last) .. Ressourcen_Neu_Vorhanden_Enum'Last;

end KartenressourcenDatentypen;
