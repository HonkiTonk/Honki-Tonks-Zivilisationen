package KartenrohstoffeDatentypen is
   pragma Pure;
   
   type Rohstoffe_Enum is (
                            Leer_Rohstoff_Enum,
                                   
                            -- Wasserrohstoffe
                            Fisch_Enum, Wal_Enum,
                            Hochwertiges_Holz_Enum,
                                   
                            -- Landrohstoffe
                            Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                     
                            -- Kernrohstoffe
                            
                           );
   pragma Ordered (Rohstoffe_Enum);
   
   subtype Rohstoffe_Vorhanden_Enum is Rohstoffe_Enum range Rohstoffe_Enum'Succ (Rohstoffe_Enum'First) .. Rohstoffe_Enum'Last;
   
   subtype Rohstoffe_Oberfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Fisch_Enum .. Wal_Enum;
   subtype Rohstoffe_Oberfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Hochwertiges_Holz_Enum .. Gold_Enum;
   
   subtype Rohstoffe_Unterfläche_Wasser_Enum is Rohstoffe_Vorhanden_Enum range Fisch_Enum .. Hochwertiges_Holz_Enum;
   subtype Rohstoffe_Unterfläche_Land_Enum is Rohstoffe_Vorhanden_Enum range Kohle_Enum .. Gold_Enum;

end KartenrohstoffeDatentypen;
