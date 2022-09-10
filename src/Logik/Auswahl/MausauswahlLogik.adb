pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with Views;
with InteraktionAuswahl;
with SystemKonstanten;
with RassenDatentypen;
with TastenbelegungDatentypen;
with ForschungKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;

with NachLogiktask;
with Vergleiche;
with EinstellungenGrafik;
with KartenberechnungenGrafik;

package body MausauswahlLogik is

   function RassenauswahlDiplomatie
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
            
      MauszeigerSchleife:
      for RassenSchleifenwert in InteraktionAuswahl.RassenMöglicheArray'Range loop
         
         case
           InteraktionAuswahl.RassenMöglich (RassenSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenDiplomatieRasse (RassenSchleifenwert))
               then
                  return RassenDatentypen.Rassen_Enum'Pos (RassenSchleifenwert);
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop MauszeigerSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end RassenauswahlDiplomatie;
   
   
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.ForschungsviewAccesse (1));
            
      MausZeigerSchleife:
      for ForschungSchleifenwert in InteraktionAuswahl.MöglicheForschungenArray'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert))
               then
                  return ForschungSchleifenwert;
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return ForschungKonstanten.LeerForschungAnforderung;
      
   end Forschungsmenü;
   
   
   
   function Baumenü
     return StadtRecords.BauprojektRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.BauviewAccesse (1));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert))
               then
                  return (GebäudeSchleifenwert, EinheitenKonstanten.LeerID);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
            
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.BauviewAccesse (2));
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert))
               then
                  return (StadtKonstanten.LeerGebäudeID, EinheitenSchleifenwert);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
               
      end loop EinheitenSchleife;
      
      return (StadtKonstanten.LeerGebäudeID, EinheitenKonstanten.LeerID);
      
   end Baumenü;
   
         
   
   function Menüs
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end Menüs;
   
   
   
   function JaNein
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.FragenviewAccesse (2));
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNein'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end JaNein;
   
         
   
   function Steuerung
     return SystemRecords.MehrfacheAuswahlRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (1));
      
      BefehleSchleife:
      for BefehleSchleifenwert in InteraktionAuswahl.PositionenSteuerung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerung (BefehleSchleifenwert))
         is
            when True =>
               return (BefehleSchleifenwert, SystemKonstanten.LeerAuswahl);
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (2));
         
      PositionSchleife:
      for PositionSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerungbelegung (PositionSchleifenwert))
         is
            when True =>
               return (SystemKonstanten.LeerAuswahl, TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Pos (PositionSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return (SystemKonstanten.LeerAuswahl, SystemKonstanten.LeerAuswahl);
      
   end Steuerung;
   
   
   
   -- Später so erweitern dass die Mausposition noch Befehlsknöpfen abfragt. äöü
   function Einheitenbefehle
     return BefehleDatentypen.Weltkartenbefehle_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenviewAccess);
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => KartenberechnungenGrafik.FensterKarte)
      is
         when True =>
            return BefehleDatentypen.Bewegen_Enum;
            
         when False =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.BefehlsviewAccess);
      end case;
      
         
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    -- Hier später die Befehlsknöpfe einbauen.
                                    TextboxExtern      => (0.00, 0.00, 0.00, 0.00))
      is
         when True =>
            return BefehleDatentypen.A_Enum;
            
         when False =>
            null;
      end case;
      
      return BefehleDatentypen.Leer_Enum;
      
   end Einheitenbefehle;
   
   
   
   function Stadtumgebung
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.StadtviewAccesse (2));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => (0.00, 0.00, Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (2)).x, Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (2)).y))
      is
         when False =>
            return (-1.00, -1.00);
            
         when True =>
            return Mausposition;
      end case;
            
   end Stadtumgebung;
   
   
   
   -- Hier und bei weiteren Befehle erst einmal prüfen ob der Mauszeiger sich überhaupt im Befehlsbereich befindet? äöü
   function Stadtbefehle
     return BefehleDatentypen.Stadtbefehle_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.StadtviewAccesse (3));
      
      BefehleSchleife:
      for BefehleSchleifenwert in InteraktionAuswahl.PositionenStadtbefehleArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenStadtbefehle (BefehleSchleifenwert))
         is
            when True =>
               return BefehleSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      return BefehleDatentypen.Leer_Enum;
      
   end Stadtbefehle;
   
   
   
   function Verkaufsmenü
     return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.VerkaufsviewAccesse (1));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenMöglicheGebäude (GebäudeSchleifenwert))
               then
                  return GebäudeSchleifenwert;
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      return StadtKonstanten.LeerGebäudeID;
      
   end Verkaufsmenü;
     
end MausauswahlLogik;
