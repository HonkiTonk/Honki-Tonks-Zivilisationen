package KartenwegeDatentypen is
   pragma Pure;
   
   type Weg_Enum is (
                     Leer_Weg_Enum,
                            
                     -- Straßen
                     Straßenkreuzung_Vier_Enum, Straße_Waagrecht_Enum, Straße_Senkrecht_Enum, Straßenkurve_Unten_Rechts_Enum, Straßenkurve_Unten_Links_Enum, Straßenkurve_Oben_Rechts_Enum,
                     Straßenkurve_Oben_Links_Enum, Straßenkreuzung_Drei_Oben_Enum, Straßenkreuzung_Drei_Unten_Enum, Straßenkreuzung_Drei_Rechts_Enum, Straßenkreuzung_Drei_Links_Enum,
                     Straßenende_Links_Enum, Straßenende_Rechts_Enum, Straßenende_Unten_Enum, Straßenende_Oben_Enum, Straße_Einzeln_Enum,
                                     
                     -- Schienen
                     Schienenkreuzung_Vier_Enum, Schiene_Waagrecht_Enum, Schiene_Senkrecht_Enum, Schienenkurve_Unten_Rechts_Enum, Schienenkurve_Unten_Links_Enum, Schienenkurve_Oben_Rechts_Enum,
                     Schienenkurve_Oben_Links_Enum, Schienenkreuzung_Drei_Oben_Enum, Schienenkreuzung_Drei_Unten_Enum, Schienenkreuzung_Drei_Rechts_Enum, Schienenkreuzung_Drei_Links_Enum,
                     Schienenende_Links_Enum, Schienenende_Rechts_Enum, Schienenende_Unten_Enum, Schienenende_Oben_Enum, Schiene_Einzeln_Enum,
                                     
                     -- Tunnel
                     Tunnelkreuzung_Vier_Enum, Tunnel_Waagrecht_Enum, Tunnel_Senkrecht_Enum, Tunnelkurve_Unten_Rechts_Enum, Tunnelkurve_Unten_Links_Enum, Tunnelkurve_Oben_Rechts_Enum,
                     Tunnelkurve_Oben_Links_Enum, Tunnelkreuzung_Drei_Oben_Enum, Tunnelkreuzung_Drei_Unten_Enum, Tunnelkreuzung_Drei_Rechts_Enum, Tunnelkreuzung_Drei_Links_Enum,
                     Tunnelende_Links_Enum, Tunnelende_Rechts_Enum, Tunnelende_Unten_Enum, Tunnelende_Oben_Enum, Tunnel_Einzeln_Enum
                    );
   
   subtype Weg_Vorhanden_Enum is Weg_Enum range Weg_Enum'Succ (Weg_Enum'First) .. Weg_Enum'Last;
   
   subtype Straße_Enum is Weg_Vorhanden_Enum range Straßenkreuzung_Vier_Enum .. Straße_Einzeln_Enum;
   subtype Schiene_Enum is Weg_Vorhanden_Enum range Schienenkreuzung_Vier_Enum .. Schiene_Einzeln_Enum;
   subtype Tunnel_Enum is Weg_Vorhanden_Enum range Tunnelkreuzung_Vier_Enum .. Tunnel_Einzeln_Enum;
   
end KartenwegeDatentypen;
