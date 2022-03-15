pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen;

package KartenVerbesserungKonstanten is
   
   LeerVerbesserung : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Leer_Verbesserung;
   LeerVerbesserungWeg : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := LeerVerbesserung;
   LeerVerbesserungGebiet : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := LeerVerbesserung;

   -- Städte
   EigeneHauptstadtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Eigene_Hauptstadt;
   EigeneStadtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Eigene_Stadt;
   FremdeHauptstadtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Fremde_Hauptstadt;
   FremdeStadtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Fremde_Stadt;
                                     
   -- Gebilde
   FarmKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Farm;
   MineKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Mine;
   FestungKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Festung;
   SperreKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Sperre;
                                     
   -- Wege - Straßen
   StraßenkreuzungVierKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkreuzung_Vier;
   StraßeWaagrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straße_Waagrecht;
   StraßeSenkrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straße_Senkrecht;
   StraßenkurveUntenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts;
   StraßenkurveUntenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkurve_Unten_Links;
   StraßenkurveObenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts;
   StraßenkurveObenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkurve_Oben_Links;
   StraßenkreuzungDreiObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben;
   StraßenkreuzungDreiUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten;
   StraßenkreuzungDreiRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts;
   StraßenkreuzungDreiLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links;
   StraßenendstückLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenendstück_Links;
   StraßenendstückRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenendstück_Rechts;
   StraßenendstückUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenendstück_Unten;
   StraßenendstückObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straßenendstück_Oben;
   StraßeEinzelnKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Straße_Einzeln;
                                     
   -- Schienen
   SchienenkreuzungVierKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkreuzung_Vier;
   SchieneWaagrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schiene_Waagrecht;
   SchieneSenkrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schiene_Senkrecht;
   SchienenkurveUntenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkurve_Unten_Rechts;
   SchienenkurveUntenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkurve_Unten_Links;
   SchienenkurveObenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkurve_Oben_Rechts;
   SchienenkurveObenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkurve_Oben_Links;
   SchienenkreuzungDreiObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkreuzung_Drei_Oben;
   SchienenkreuzungDreiUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkreuzung_Drei_Unten;
   SchienenkreuzungDreiRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkreuzung_Drei_Rechts;
   SchienenkreuzungDreiLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenkreuzung_Drei_Links;
   SchienenendstückLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenendstück_Links;
   SchienenendstückRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenendstück_Rechts;
   SchienenendstückUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenendstück_Unten;
   SchienenendstückObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schienenendstück_Oben;
   SchieneEinzelnKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Schiene_Einzeln;
                                     
   -- Tunnel
   Tunnelkreuzung_VierKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkreuzung_Vier;
   TunnelWaagrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnel_Waagrecht;
   TunnelSenkrechtKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnel_Senkrecht;
   TunnelkurveUntenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkurve_Unten_Rechts;
   TunnelkurveUntenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkurve_Unten_Links;
   TunnelkurveObenRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkurve_Oben_Rechts;
   TunnelkurveObenLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkurve_Oben_Links;
   TunnelkreuzungDreiObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkreuzung_Drei_Oben;
   TunnelkreuzungDreiUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkreuzung_Drei_Unten;
   TunnelkreuzungDreiRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkreuzung_Drei_Rechts;
   TunnelkreuzungDreiLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelkreuzung_Drei_Links;
   TunnelendstückLinksKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelendstück_Links;
   TunnelendstückRechtsKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelendstück_Rechts;
   TunnelendstückUntenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelendstück_Unten;
   TunnelendstückObenKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnelendstück_Oben;
   TunnelEinzelnKonstante : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Enum := KartenVerbesserungDatentypen.Tunnel_Einzeln;

end KartenVerbesserungKonstanten;
