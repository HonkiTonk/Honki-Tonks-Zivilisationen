with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with Views;
with InteraktionAuswahl;
with SpeziesDatentypen;
with ForschungKonstanten;
with StadtKonstanten;
with ViewKonstanten;
with GrafikRecordKonstanten;
with AuswahlKonstanten;

with Vergleiche;
with SichtweitenGrafik;
with FensterGrafik;
with MausauswahlAllgemeinLogik;

-- Thematisch aufteilen? äöü
-- Mal schauen ob die Vorabprüfung ob der Mauszeiger überhaupt im richtigen Bereich ist noch fehlerfrei überall eingebaut werden kann. äöü
package body MausauswahlLogik is

   -- Hier ist gar nicht der aufgeteilte Viewbereich drin, ist das nicht auch aufgeteilt? äöü
   function SpeziesauswahlDiplomatie
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl));
      
      DiplomatieSchleife:
      for SpeziesSchleifenwert in InteraktionAuswahl.SpeziesMöglicheArray'Range loop
         
         case
           InteraktionAuswahl.SpeziesMöglich (SpeziesSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    RechteckExtern     => InteraktionAuswahl.PositionenDiplomatieSpezies (SpeziesSchleifenwert))
               then
                  return SpeziesDatentypen.Spezies_Enum'Pos (SpeziesSchleifenwert);
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop DiplomatieSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end SpeziesauswahlDiplomatie;
   
   
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungID
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüForschungsliste));
      
      case
        MausauswahlAllgemeinLogik.MauszeigerImView (MauspositionExtern => Mausposition,
                                                    BereichExtern      => (GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).width,
                                                                           GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüForschungsliste).height))
      is
         when False =>
            return ForschungKonstanten.LeerAnforderung;

         when True =>
            null;
      end case;
      
      ForschungSchleife:
      for ForschungSchleifenwert in InteraktionAuswahl.MöglicheForschungenArray'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    RechteckExtern     => InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert))
               then
                  return ForschungSchleifenwert;
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop ForschungSchleife;
      
      return ForschungKonstanten.LeerAnforderung;
      
   end Forschungsmenü;
   
   
   
   function Baumenü
     return StadtRecords.BauprojektauswahlRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüKategorie));
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenBauaufteilung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenBauaufteilung (AufteilungSchleifenwert))
         is
            when True =>
               return (AuswahlKonstanten.LeerAuswahl, AufteilungSchleifenwert);
               
            when False =>
               null;
         end case;
         
      end loop AufteilungSchleife;
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüBauliste));
      
      BauprojektSchleife:
      for BauprojektSchleifenwert in InteraktionAuswahl.PositionenBaumöglichkeiten'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenBaumöglichkeiten (BauprojektSchleifenwert))
         is
            when True =>
               return (BauprojektSchleifenwert, StadtDatentypen.Leer_Bauprojektart);
               
            when False =>
               null;
         end case;
         
      end loop BauprojektSchleife;
      
      return (AuswahlKonstanten.LeerAuswahl, StadtDatentypen.Leer_Bauprojektart);
      
   end Baumenü;
   
         
   
   function Menüs
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl));
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end Menüs;
   
   
   
   function JaNein
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.FragenviewAccesse (ViewKonstanten.Antwort));
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNein'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end JaNein;
   
         
   
   function Steuerung
     return Integer
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungKategorie));
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenSteuerungsaufteilung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenSteuerungsaufteilung (AufteilungSchleifenwert))
         is
            when True =>
               return -AufteilungSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop AufteilungSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungAuswahl));
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in InteraktionAuswahl.PositionenSteuerung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenSteuerung (SteuerungSchleifenwert))
         is
            when True =>
               return SteuerungSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop SteuerungSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end Steuerung;
   
   
   
   function Weltkartenbefehle
     return TastenbelegungDatentypen.Weltkartenbefehle_Enum
   is begin
            
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.KartenbefehlsviewAccess);
      
      BefehleSchleife:
      for BefehlSchleifenwert in InteraktionAuswahl.PositionenKartenbefehleArray'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenKartenbefehle (BefehlSchleifenwert))
         is
            when True =>
               return BefehlSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    RechteckExtern     => (0.00, 0.00, Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)).x,
                                                           Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)).y))
      is
         when True =>
            return TastenbelegungDatentypen.Auswählen_Enum;
            
         when False =>
            return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
      end case;
      
   end Weltkartenbefehle;
   
   
   
   function Einheitenbefehle
     return BefehleDatentypen.Einheitenbelegung_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.EinheitenbefehlsviewAccess);
      
      BefehleSchleife:
      for BefehlSchleifenwert in InteraktionAuswahl.PositionenEinheitenbefehleArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenEinheitenbefehle (BefehlSchleifenwert))
         is
            when True =>
               return BefehlSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      
      case
        Vergleiche.AuswahlpositionVereinfacht (MauspositionExtern => Mausposition,
                                               VektorExtern       => SichtweitenGrafik.Kartenfläche)
      is
         when True =>
            return BefehleDatentypen.Auswählen_Enum;
            
         when False =>
            return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
      end case;
      
   end Einheitenbefehle;
   
   
   
   function Stadtumgebung
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung));
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    RechteckExtern     => (0.00, 0.00, Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).x,
                                                           Sf.Graphics.View.getSize (view => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung)).y))
      is
         when False =>
            return GrafikRecordKonstanten.FalschePosition;
            
         when True =>
            return Mausposition;
      end case;
            
   end Stadtumgebung;
   
   
   
   function Stadtbefehle
     return BefehleDatentypen.Stadtbefehle_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.StadtviewAccesse (ViewKonstanten.StadtBefehle));
      
      BefehleSchleife:
      for BefehleSchleifenwert in InteraktionAuswahl.PositionenStadtbefehleArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenStadtbefehle (BefehleSchleifenwert))
         is
            when True =>
               return BefehleSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      return BefehleDatentypen.Leer_Stadtbefehle_Enum;
      
   end Stadtbefehle;
   
   
   
   function Verkaufsmenü
     return StadtDatentypen.GebäudeID
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.BauviewAccesse (ViewKonstanten.BaumenüGebäudelisteVerkaufen));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    RechteckExtern     => InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert))
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
   
   
   
   function SpeichernLaden
     return Integer
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandKategorie));
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenSpielstandaufteilung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenSpielstandaufteilung (AufteilungSchleifenwert))
         is
            when True =>
               return -AufteilungSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop AufteilungSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandAuswahl));
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in InteraktionAuswahl.PositionenSpielstand'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenSpielstand (SpielstandSchleifenwert))
         is
            when True =>
               return SpielstandSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop SpielstandSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end SpeichernLaden;
   
   
   
   function StadtEinheitauswahl
     (AnfangExtern : in EinheitenDatentypen.Transportplätze;
      EndeExtern : in EinheitenDatentypen.TransportplätzeVorhanden)
      return Integer
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.StadtEinheitviewAccess);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in AnfangExtern .. EndeExtern loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert))
         is
            when True =>
               return Natural (AuswahlSchleifenwert);
               
            when False =>
               null;
         end case;
         
      end loop AuswahlSchleife;
              
      return -1;
      
   end StadtEinheitauswahl;
   
   
   
   function Sprachenauswahl
     (AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl));
      
      MausZeigerSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => InteraktionAuswahl.PositionenSprachauswahl (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return AuswahlKonstanten.LeerAuswahl;
      
   end Sprachenauswahl;
   
end MausauswahlLogik;
