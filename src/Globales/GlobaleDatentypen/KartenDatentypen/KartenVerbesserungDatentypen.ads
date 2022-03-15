pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenVerbesserungDatentypen is

   -- Immer dran denken, alle Wegearten am Schluss hinzufügen.
   type Karten_Verbesserung_Enum is (Leer_Verbesserung,
                                     
                                     -- Städte
                                     Eigene_Hauptstadt, Eigene_Stadt,
                                     Fremde_Hauptstadt, Fremde_Stadt,
                                     
                                     -- Gebilde
                                     Farm, Mine,
                                     Festung, Sperre,
                                     
                                     -- Wege - Straßen
                                     Straßenkreuzung_Vier, Straße_Waagrecht, Straße_Senkrecht, Straßenkurve_Unten_Rechts, Straßenkurve_Unten_Links, Straßenkurve_Oben_Rechts, Straßenkurve_Oben_Links,
                                     Straßenkreuzung_Drei_Oben, Straßenkreuzung_Drei_Unten, Straßenkreuzung_Drei_Rechts, Straßenkreuzung_Drei_Links, Straßenendstück_Links, Straßenendstück_Rechts,
                                     Straßenendstück_Unten, Straßenendstück_Oben, Straße_Einzeln,
                                     
                                     -- Schienen
                                     Schienenkreuzung_Vier, Schiene_Waagrecht, Schiene_Senkrecht, Schienenkurve_Unten_Rechts, Schienenkurve_Unten_Links, Schienenkurve_Oben_Rechts, Schienenkurve_Oben_Links,
                                     Schienenkreuzung_Drei_Oben, Schienenkreuzung_Drei_Unten, Schienenkreuzung_Drei_Rechts, Schienenkreuzung_Drei_Links, Schienenendstück_Links, Schienenendstück_Rechts,
                                     Schienenendstück_Unten, Schienenendstück_Oben, Schiene_Einzeln,
                                     
                                     -- Tunnel
                                     Tunnelkreuzung_Vier, Tunnel_Waagrecht, Tunnel_Senkrecht, Tunnelkurve_Unten_Rechts, Tunnelkurve_Unten_Links, Tunnelkurve_Oben_Rechts, Tunnelkurve_Oben_Links,
                                     Tunnelkreuzung_Drei_Oben, Tunnelkreuzung_Drei_Unten, Tunnelkreuzung_Drei_Rechts, Tunnelkreuzung_Drei_Links, Tunnelendstück_Links, Tunnelendstück_Rechts,
                                     Tunnelendstück_Unten, Tunnelendstück_Oben, Tunnel_Einzeln
                                    );
   
   subtype Karten_Verbesserung_Vorhanden_Enum is Karten_Verbesserung_Enum range Eigene_Hauptstadt .. Karten_Verbesserung_Enum'Last;

   subtype Karten_Verbesserung_Stadt_ID_Enum is Karten_Verbesserung_Enum range Leer_Verbesserung .. Eigene_Stadt;
   subtype Karten_Verbesserung_Städte_Enum is Karten_Verbesserung_Vorhanden_Enum range Eigene_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Eigene_Städte_Enum is Karten_Verbesserung_Städte_Enum range Eigene_Hauptstadt .. Eigene_Stadt;
   subtype Karten_Verbesserung_Fremde_Städte_Enum is Karten_Verbesserung_Städte_Enum range Fremde_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Gebilde_Enum is Karten_Verbesserung_Vorhanden_Enum range Farm .. Sperre;
   subtype Karten_Verbesserung_Gebilde_Friedlich_Enum is Karten_Verbesserung_Gebilde_Enum range Farm .. Mine;
   subtype Karten_Verbesserung_Gebilde_Kampf_Enum is Karten_Verbesserung_Gebilde_Enum range Festung .. Sperre;
   subtype Karten_Weg_Enum is Karten_Verbesserung_Vorhanden_Enum range Straßenkreuzung_Vier .. Karten_Verbesserung_Vorhanden_Enum'Last;
   subtype Karten_Verbesserung_Weg_Enum is Karten_Weg_Enum range Straßenkreuzung_Vier .. Straße_Einzeln;
   subtype Karten_Verbesserung_Schiene_Enum is Karten_Weg_Enum range Schienenkreuzung_Vier .. Schiene_Einzeln;
   subtype Karten_Verbesserung_Tunnel_Enum is Karten_Weg_Enum range Tunnelkreuzung_Vier .. Tunnel_Einzeln;
   
   -- type Karten_Weg_Enum is (Leer_Weg);

end KartenVerbesserungDatentypen;
