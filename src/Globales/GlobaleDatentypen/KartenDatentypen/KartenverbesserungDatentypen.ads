package KartenverbesserungDatentypen is
   pragma Pure;

   -- Das hier auch mal teilweise erweitern, so dass die Grafiken dann über verschiedene Felder hinweg möglich sind? äöü
   type Verbesserung_Enum is (
                              Leer_Verbesserung_Enum,
                                     
                              -- Städte
                              Hauptstadt_Enum, Stadt_Enum,
                                     
                              -- Friedlich
                              Farm_Enum, Mine_Enum,
                                     
                              -- Krieg
                              Festung_Enum
                             );
   
   subtype Verbesserung_Vorhanden_Enum is Verbesserung_Enum range Verbesserung_Enum'Succ (Verbesserung_Enum'First) .. Verbesserung_Enum'Last;

   subtype Verbesserung_Stadt_ID_Enum is Verbesserung_Enum range Leer_Verbesserung_Enum .. Stadt_Enum;
   subtype Verbesserung_Städte_Enum is Verbesserung_Stadt_ID_Enum range Hauptstadt_Enum .. Stadt_Enum;
   subtype Verbesserung_Gebilde_Enum is Verbesserung_Vorhanden_Enum range Farm_Enum .. Verbesserung_Vorhanden_Enum'Last;
   subtype Verbesserung_Gebilde_Friedlich_Enum is Verbesserung_Gebilde_Enum range Farm_Enum .. Mine_Enum;
   subtype Verbesserung_Gebilde_Kampf_Enum is Verbesserung_Gebilde_Enum range Festung_Enum .. Festung_Enum;
   
   
   
   type Weg_Enum is (
                     Leer_Weg_Enum,
                            
                     -- Wege - Straßen
                     Straßenkreuzung_Vier_Enum, Straße_Waagrecht_Enum, Straße_Senkrecht_Enum, Straßenkurve_Unten_Rechts_Enum, Straßenkurve_Unten_Links_Enum, Straßenkurve_Oben_Rechts_Enum,
                     Straßenkurve_Oben_Links_Enum, Straßenkreuzung_Drei_Oben_Enum, Straßenkreuzung_Drei_Unten_Enum, Straßenkreuzung_Drei_Rechts_Enum, Straßenkreuzung_Drei_Links_Enum,
                     Straßenendstück_Links_Enum, Straßenendstück_Rechts_Enum, Straßenendstück_Unten_Enum, Straßenendstück_Oben_Enum, Straße_Einzeln_Enum,
                                     
                     -- Schienen
                     Schienenkreuzung_Vier_Enum, Schiene_Waagrecht_Enum, Schiene_Senkrecht_Enum, Schienenkurve_Unten_Rechts_Enum, Schienenkurve_Unten_Links_Enum, Schienenkurve_Oben_Rechts_Enum,
                     Schienenkurve_Oben_Links_Enum, Schienenkreuzung_Drei_Oben_Enum, Schienenkreuzung_Drei_Unten_Enum, Schienenkreuzung_Drei_Rechts_Enum, Schienenkreuzung_Drei_Links_Enum,
                     Schienenendstück_Links_Enum, Schienenendstück_Rechts_Enum, Schienenendstück_Unten_Enum, Schienenendstück_Oben_Enum, Schiene_Einzeln_Enum,
                                     
                     -- Tunnel
                     Tunnelkreuzung_Vier_Enum, Tunnel_Waagrecht_Enum, Tunnel_Senkrecht_Enum, Tunnelkurve_Unten_Rechts_Enum, Tunnelkurve_Unten_Links_Enum, Tunnelkurve_Oben_Rechts_Enum,
                     Tunnelkurve_Oben_Links_Enum, Tunnelkreuzung_Drei_Oben_Enum, Tunnelkreuzung_Drei_Unten_Enum, Tunnelkreuzung_Drei_Rechts_Enum, Tunnelkreuzung_Drei_Links_Enum,
                     Tunnelendstück_Links_Enum, Tunnelendstück_Rechts_Enum, Tunnelendstück_Unten_Enum, Tunnelendstück_Oben_Enum, Tunnel_Einzeln_Enum
                    );
   
   subtype Weg_Vorhanden_Enum is Weg_Enum range Weg_Enum'Succ (Weg_Enum'First) .. Weg_Enum'Last;
   
   subtype Straße_Enum is Weg_Vorhanden_Enum range Straßenkreuzung_Vier_Enum .. Straße_Einzeln_Enum;
   subtype Schiene_Enum is Weg_Vorhanden_Enum range Schienenkreuzung_Vier_Enum .. Schiene_Einzeln_Enum;
   subtype Tunnel_Enum is Weg_Vorhanden_Enum range Tunnelkreuzung_Vier_Enum .. Tunnel_Einzeln_Enum;

end KartenverbesserungDatentypen;
