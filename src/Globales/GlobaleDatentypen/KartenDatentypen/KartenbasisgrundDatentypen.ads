package KartenbasisgrundDatentypen is
   pragma Pure;
   
   -- Es sind immer 16 Elemente bei den Mehrfachmöglichkeiten.
  
   -- Alle nötigen Möglichkeiten ergeben 29 Elemente, sollte ich diese auch einbauen? äöü
   -- Bräuchte dann auch noch Extrabasisgrund für den Übergangsbereich zu allen anderen Gründen, inklusive Wasser. äöü
   
   type Basisgrund_Enum is (
                            Leer_Basisgrund_Enum,
                             
                            -- Orbit
                            Orbit_Enum,
                              
                            -- Himmel
                            Wolken_Enum,
                              
                            -- Oberfläche
                            Meer_Enum,
                            -- Wasser zu Küstengewässer in alle Richtungen einzeln und mehrfach. äöü
                            -- Wäre aber auch halt komplett übertrieben, will ich das? äöü
                            Küstengewässer_Enum,
                            
                            Eis_Enum,
                            Arktisch_Enum, Tundra_Enum, Grasland_Enum, Steppe_Enum, Savanne_Enum, Wüste_Enum,
                            
                            Hügelkreuzung_Vier_Enum, Hügel_Waagrecht_Enum, Hügel_Senkrecht_Enum, Hügelkurve_Unten_Rechts_Enum, Hügelkurve_Unten_Links_Enum, Hügelkurve_Oben_Rechts_Enum, Hügelkurve_Oben_Links_Enum,
                            Hügelkreuzung_Drei_Oben_Enum, Hügelkreuzung_Drei_Unten_Enum, Hügelkreuzung_Drei_Rechts_Enum, Hügelkreuzung_Drei_Links_Enum, Hügelende_Links_Enum, Hügelende_Rechts_Enum,
                            Hügelende_Unten_Enum, Hügelende_Oben_Enum, Hügel_Enum,
                            
                            Gebirgekreuzung_Vier_Enum, Gebirge_Waagrecht_Enum, Gebirge_Senkrecht_Enum, Gebirgekurve_Unten_Rechts_Enum, Gebirgekurve_Unten_Links_Enum, Gebirgekurve_Oben_Rechts_Enum,
                            Gebirgekurve_Oben_Links_Enum, Gebirgekreuzung_Drei_Oben_Enum, Gebirgekreuzung_Drei_Unten_Enum, Gebirgekreuzung_Drei_Rechts_Enum, Gebirgekreuzung_Drei_Links_Enum,
                            Gebirgeende_Links_Enum, Gebirgeende_Rechts_Enum, Gebirgeende_Unten_Enum, Gebirgeende_Oben_Enum, Gebirge_Enum,
                            
                            -- Unterfläche
                            Meeresgrund_Enum, Küstengrund_Enum,
                            Untereis_Enum,
                            Erde_Enum, Erdgestein_Enum, Sand_Enum, Gestein_Enum,
                              
                            -- Planetenkern
                            Planetenkern_Enum, Lava_Enum,
                            Ringwoodit_Enum, Majorit_Enum, Perowskit_Enum, Magnesiowüstit_Enum,
                              
                            -- Sonstiges
                            Vernichtet_Enum
                              
                              -- 0, 1, 2, 3, 4, 5, 6
                           );
   pragma Ordered (Basisgrund_Enum);
      
   subtype Basisgrund_Vorhanden_Enum is Basisgrund_Enum range Basisgrund_Enum'Succ (Basisgrund_Enum'First) .. Basisgrund_Enum'Last;
   
   -- Orbit
   subtype Basisgrund_Orbit_Enum is Basisgrund_Vorhanden_Enum range Orbit_Enum .. Orbit_Enum;
   
   -- Himmel
   subtype Basisgrund_Himmel_Enum is Basisgrund_Vorhanden_Enum range Wolken_Enum .. Wolken_Enum;
   
   -- Oberfläche
   subtype Basisgrund_Oberfläche_Enum is Basisgrund_Vorhanden_Enum range Meer_Enum .. Gebirge_Enum;
   
   subtype Basisgrund_Oberfläche_Eiswasser_Enum is Basisgrund_Oberfläche_Enum range Meer_Enum .. Eis_Enum;
   subtype Basisgrund_Oberfläche_Wasser_Enum is Basisgrund_Oberfläche_Eiswasser_Enum range Meer_Enum .. Küstengewässer_Enum;
   
   subtype Basisgrund_Gesamtoberfläche_Land_Enum is Basisgrund_Oberfläche_Enum range Eis_Enum .. Gebirge_Enum;
   subtype Basisgrund_Oberfläche_Land_Enum is Basisgrund_Gesamtoberfläche_Land_Enum range Basisgrund_Enum'Succ (Basisgrund_Gesamtoberfläche_Land_Enum'First) .. Gebirge_Enum;
   
   subtype Basisgrund_Eis_Enum is Basisgrund_Gesamtoberfläche_Land_Enum range Eis_Enum .. Eis_Enum;
   subtype Basisgrund_Arktisch_Enum is Basisgrund_Gesamtoberfläche_Land_Enum range Arktisch_Enum .. Arktisch_Enum;
   subtype Basisgrund_Tundra_Enum is Basisgrund_Oberfläche_Land_Enum range Tundra_Enum .. Tundra_Enum;
   subtype Basisgrund_Grasland_Enum is Basisgrund_Oberfläche_Land_Enum range Grasland_Enum .. Grasland_Enum;
   subtype Basisgrund_Steppe_Enum is Basisgrund_Oberfläche_Land_Enum range Steppe_Enum .. Steppe_Enum;
   subtype Basisgrund_Savanne_Enum is Basisgrund_Oberfläche_Land_Enum range Savanne_Enum .. Savanne_Enum;
   subtype Basisgrund_Wüste_Enum is Basisgrund_Oberfläche_Land_Enum range Wüste_Enum .. Wüste_Enum;
   subtype Basisgrund_Hügel_Enum is Basisgrund_Oberfläche_Land_Enum range Hügelkreuzung_Vier_Enum .. Hügel_Enum;
   subtype Basisgrund_Gebirge_Enum is Basisgrund_Oberfläche_Land_Enum range Gebirgekreuzung_Vier_Enum .. Gebirge_Enum;
   
   -- Unterfläche
   subtype Basisgrund_Unterfläche_Enum is Basisgrund_Vorhanden_Enum range Meeresgrund_Enum .. Gestein_Enum;
   
   subtype Basisgrund_Unterfläche_Eiswasser_Enum is Basisgrund_Unterfläche_Enum range Meeresgrund_Enum .. Untereis_Enum;
   subtype Basisgrund_Unterfläche_Wasser_Enum is Basisgrund_Unterfläche_Eiswasser_Enum range Meeresgrund_Enum .. Küstengrund_Enum;
   
   subtype Basisgrund_Gesamtunterfläche_Land_Enum is Basisgrund_Unterfläche_Enum range Untereis_Enum .. Gestein_Enum;
   subtype Basisgrund_Unterfläche_Land_Enum is Basisgrund_Gesamtunterfläche_Land_Enum range Basisgrund_Enum'Succ (Basisgrund_Gesamtunterfläche_Land_Enum'First) .. Gestein_Enum;
   
   -- Planeteinneres
   subtype Basisgrund_Kernfläche_Enum is Basisgrund_Vorhanden_Enum range Planetenkern_Enum .. Magnesiowüstit_Enum;
   subtype Basisgrund_Kernfläche_Flüssig_Enum is Basisgrund_Kernfläche_Enum range Planetenkern_Enum .. Lava_Enum;
   
   subtype Basisgrund_Kernfläche_Fest_Enum is Basisgrund_Kernfläche_Enum range Ringwoodit_Enum .. Magnesiowüstit_Enum;
   
   -- Sonstiges
   subtype Basisgrund_Sonstiges_Enum is Basisgrund_Vorhanden_Enum range Vernichtet_Enum .. Vernichtet_Enum;

end KartenbasisgrundDatentypen;
