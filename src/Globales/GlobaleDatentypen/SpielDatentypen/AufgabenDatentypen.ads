package AufgabenDatentypen is
   pragma Pure;

   type Einheiten_Aufgaben_Enum is (
                                    Leer_Aufgabe_Enum,
                                    
                                    -- Einheitenbefehle Verbesserungen
                                    -- Wege
                                    Straße_Bauen_Enum, Schiene_Bauen_Enum, Tunnel_Bauen_Enum,
                                    
                                    -- Gebäude
                                    Mine_Bauen_Enum, Farm_Bauen_Enum, Festung_Bauen_Enum,
                                    
                                    -- Gelände
                                    Wald_Aufforsten_Enum, Roden_Trockenlegen_Enum,
                                    
                                    Feldeffekt_Entfernen_Enum,
                                    -- Strahlung_Entfernen_Enum, Biologisch_Entfernen_Enum, Chemisch_Entfernen_Enum, Verschmutzung_Entfernen_Enum,
                                    
                                    -- Einheitenbefehle allgemein
                                    Heilen_Enum, Verschanzen_Enum
                                   );
   
   subtype Einheiten_Aufgabe_Vorhanden_Enum is Einheiten_Aufgaben_Enum range Einheiten_Aufgaben_Enum'Succ (Einheiten_Aufgaben_Enum'First) .. Einheiten_Aufgaben_Enum'Last;
   
   subtype Einheitenbefehle_Verbesserungen_Enum is Einheiten_Aufgabe_Vorhanden_Enum range Straße_Bauen_Enum .. Feldeffekt_Entfernen_Enum;
   subtype Einheitenbefehle_Wege_Enum is Einheitenbefehle_Verbesserungen_Enum range Straße_Bauen_Enum .. Tunnel_Bauen_Enum;
   subtype Einheitenbefehle_Gebilde_Enum is Einheitenbefehle_Verbesserungen_Enum range Mine_Bauen_Enum .. Festung_Bauen_Enum;
   subtype Einheitenbefehle_Gelände_Enum is Einheitenbefehle_Verbesserungen_Enum range Wald_Aufforsten_Enum .. Feldeffekt_Entfernen_Enum;
   subtype Einheitenbefehle_Feldeffekte_Enum is Einheitenbefehle_Verbesserungen_Enum range Feldeffekt_Entfernen_Enum .. Feldeffekt_Entfernen_Enum;
     
   subtype Einheitenbefehle_Allgemein_Enum is Einheiten_Aufgabe_Vorhanden_Enum range Heilen_Enum .. Verschanzen_Enum;

end AufgabenDatentypen;
