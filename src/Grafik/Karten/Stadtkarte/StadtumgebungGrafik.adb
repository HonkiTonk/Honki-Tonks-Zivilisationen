with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with KartenDatentypen;
with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with TextaccessVariablen;
with Meldungstexte;
with SpeziesKonstanten;
with TextnummernKonstanten;

with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenfelderwerteLogik;
with EinstellungenGrafik;
with TexteinstellungenGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Viewfläche := (7.00 * SichtweitenGrafik.KartenfelderAbmessung.x, 7.00 * SichtweitenGrafik.KartenfelderAbmessung.y);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      Viewfläche := (0.00, 0.00);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.EAchse = KartenKonstanten.LeerEAchse
            then
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.KartenfelderAbmessung,
                                                       PositionExtern  => Viewfläche,
                                                       FarbeExtern     => Sf.Graphics.Color.sfBlack);
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern       => StadtSpeziesNummerExtern.Spezies)
            then
               null;
               
            else
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                          YKoordinateExtern      => YAchseSchleifenwert,
                                                          XKoordinateExtern      => XAchseSchleifenwert)
               is
                  when True =>
                     FeldBewirtschaftet := True;
               
                  when False =>
                     FeldBewirtschaftet := False;
               end case;
            
               DarstellungUmgebung (KarteKoordinatenExtern => KartenWert,
                                    PositionExtern         => Viewfläche,
                                    StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                    BewirtschaftetExtern   => FeldBewirtschaftet);
            end if;
            
            Viewfläche.x := Viewfläche.x + SichtweitenGrafik.KartenfelderAbmessung.x;
            
         end loop XAchseSchleife;
         
         Viewfläche := (0.00, Viewfläche.y + SichtweitenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
      
   end Stadtumgebung;
   
   
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      Grundbelegung := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KarteKoordinatenExtern);
      Rahmendicke := (SichtweitenGrafik.KartenfelderAbmessung.y / 20.00 + SichtweitenGrafik.KartenfelderAbmessung.x / 20.00) / 2.00;
      
      if
        Grundbelegung.Spezies = SpeziesKonstanten.LeerSpezies
      then
         return;
        
      elsif
        Grundbelegung = StadtSpeziesNummerExtern
      then
         case
           BewirtschaftetExtern
         is
            when True =>
               Farbe := Sf.Graphics.Color.sfGreen;
               Wirtschaftsinformationen (KoordinatenExtern => KarteKoordinatenExtern,
                                         PositionExtern    => (PositionExtern.x, PositionExtern.y + Rahmendicke),
                                         SpeziesExtern       => StadtSpeziesNummerExtern.Spezies);
               
            when False =>
               Farbe := Sf.Graphics.Color.sfBlue;
         end case;
            
      elsif
        Grundbelegung.Spezies = StadtSpeziesNummerExtern.Spezies
      then
         Farbe := Sf.Graphics.Color.sfCyan;
         
      else
         Farbe := Sf.Graphics.Color.sfRed;
      end if;
            
      ObjekteZeichnenGrafik.RahmenZeichnen (PositionExtern    => (PositionExtern.x + Rahmendicke, PositionExtern.y + Rahmendicke),
                                            FarbeExtern       => Farbe,
                                            GrößeExtern       => (SichtweitenGrafik.KartenfelderAbmessung.x - 2.00 * Rahmendicke, SichtweitenGrafik.KartenfelderAbmessung.y - 2.00 * Rahmendicke),
                                            RahmendickeExtern => Rahmendicke);
      
   end DarstellungUmgebung;
   
   
   
   procedure Wirtschaftsinformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TextAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
        
      ProduktionSchleife:
      for ProduktionSchleifenwert in 1 .. 4 loop
         
         case
           ProduktionSchleifenwert
         is
            when 1 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                                  str  => KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                              SpeziesExtern       => SpeziesExtern)'Wide_Wide_Image
                                                  & To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel)));
               
            when 2 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                                  str  => KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                 SpeziesExtern       => SpeziesExtern)'Wide_Wide_Image
                                                  & To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion)));
               
            when 3 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                                  str  => KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                           SpeziesExtern       => SpeziesExtern)'Wide_Wide_Image
                                                  & To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion)));
               
            when 4 =>
               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                                  str  => KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                             SpeziesExtern       => SpeziesExtern)'Wide_Wide_Image
                                                  & To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion)));
         end case;
                  
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                       position => (PositionExtern.x, SichtweitenGrafik.KartenfelderAbmessung.y / 5.00 * Float (ProduktionSchleifenwert - 1) + PositionExtern.y));
         
         Textfläche := (Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).width, Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).height);
         
         if
           Textfläche.x >= SichtweitenGrafik.KartenfelderAbmessung.x
         then
            Skalierung.x := SichtweitenGrafik.KartenfelderAbmessung.x / Textfläche.x;
            
         else
            Skalierung.x := Textfläche.x / SichtweitenGrafik.KartenfelderAbmessung.x;
         end if;
         
         if
           Textfläche.y <= SichtweitenGrafik.KartenfelderAbmessung.y / 5.00
         then
            Skalierung.y := SichtweitenGrafik.KartenfelderAbmessung.y / Textfläche.y;
            
         else
            Skalierung.y := Textfläche.y / SichtweitenGrafik.KartenfelderAbmessung.y;
         end if;
         
         Sf.Graphics.Text.setScale (text  => TextaccessVariablen.TextAccess,
                                    scale => Skalierung);
            
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.TextAccess);
         
      end loop ProduktionSchleife;
      
      Sf.Graphics.Text.setScale (text  => TextaccessVariablen.TextAccess,
                                 scale => (1.00, 1.00));
      
   end Wirtschaftsinformationen;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (Gesamtgrund.Basisgrund),
                                                                PositionExtern     => PositionExtern);
        
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (Gesamtgrund.Zusatzgrund),
                                                                      PositionExtern     => PositionExtern);
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.KartenflussAccess (KartenfeldFluss),
                                                                      PositionExtern     => PositionExtern);
      end case;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.KartenressourceAccess (KartenfeldRessource),
                                                                      PositionExtern     => PositionExtern);
      end case;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                                      PositionExtern     => PositionExtern);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                                      PositionExtern     => PositionExtern);
      end case;
      
   end VerbesserungZeichnen;

end StadtumgebungGrafik;
