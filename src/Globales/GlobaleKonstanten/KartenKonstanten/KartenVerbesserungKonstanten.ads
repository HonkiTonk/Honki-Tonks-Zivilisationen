pragma SPARK_Mode (On);

with KartenDatentypen;

package KartenVerbesserungKonstanten is
   
   LeerVerbesserung : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer_Verbesserung;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := LeerVerbesserung;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := LeerVerbesserung;

   -- Städte
   EigeneHauptstadtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Eigene_Hauptstadt;
   EigeneStadtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Eigene_Stadt;
   FremdeHauptstadtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Fremde_Hauptstadt;
   FremdeStadtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Fremde_Stadt;
                                     
   -- Gebilde
   FarmKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Farm;
   MineKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Mine;
   FestungKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Festung;
   SperreKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Sperre;
                                     
   -- Wege - Straßen
   StraßenkreuzungVierKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkreuzung_Vier;
   StraßeWaagrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straße_Waagrecht;
   StraßeSenkrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straße_Senkrecht;
   StraßenkurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkurve_Unten_Rechts;
   StraßenkurveUntenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkurve_Unten_Links;
   StraßenkurveObenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkurve_Oben_Rechts;
   StraßenkurveObenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkurve_Oben_Links;
   StraßenkreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkreuzung_Drei_Oben;
   StraßenkreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkreuzung_Drei_Unten;
   StraßenkreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkreuzung_Drei_Rechts;
   StraßenkreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenkreuzung_Drei_Links;
   StraßenendstückLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenendstück_Links;
   StraßenendstückRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenendstück_Rechts;
   StraßenendstückUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenendstück_Unten;
   StraßenendstückObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straßenendstück_Oben;
   StraßeEinzelnKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Straße_Einzeln;
                                     
   -- Schienen
   SchienenkreuzungVierKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkreuzung_Vier;
   SchieneWaagrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schiene_Waagrecht;
   SchieneSenkrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schiene_Senkrecht;
   SchienenkurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkurve_Unten_Rechts;
   SchienenkurveUntenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkurve_Unten_Links;
   SchienenkurveObenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkurve_Oben_Rechts;
   SchienenkurveObenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkurve_Oben_Links;
   SchienenkreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkreuzung_Drei_Oben;
   SchienenkreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkreuzung_Drei_Unten;
   SchienenkreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkreuzung_Drei_Rechts;
   SchienenkreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenkreuzung_Drei_Links;
   SchienenendstückLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenendstück_Links;
   SchienenendstückRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenendstück_Rechts;
   SchienenendstückUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenendstück_Unten;
   SchienenendstückObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schienenendstück_Oben;
   SchieneEinzelnKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Schiene_Einzeln;
                                     
   -- Tunnel
   Tunnelkreuzung_VierKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkreuzung_Vier;
   TunnelWaagrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnel_Waagrecht;
   TunnelSenkrechtKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnel_Senkrecht;
   TunnelkurveUntenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkurve_Unten_Rechts;
   TunnelkurveUntenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkurve_Unten_Links;
   TunnelkurveObenRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkurve_Oben_Rechts;
   TunnelkurveObenLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkurve_Oben_Links;
   TunnelkreuzungDreiObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkreuzung_Drei_Oben;
   TunnelkreuzungDreiUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkreuzung_Drei_Unten;
   TunnelkreuzungDreiRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkreuzung_Drei_Rechts;
   TunnelkreuzungDreiLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelkreuzung_Drei_Links;
   TunnelendstückLinksKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelendstück_Links;
   TunnelendstückRechtsKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelendstück_Rechts;
   TunnelendstückUntenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelendstück_Unten;
   TunnelendstückObenKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnelendstück_Oben;
   TunnelEinzelnKonstante : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tunnel_Einzeln;

end KartenVerbesserungKonstanten;
