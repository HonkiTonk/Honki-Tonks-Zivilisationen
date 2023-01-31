with Sf.Graphics.Text;

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
-- with SichtweitenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenfelderwerteLogik;
with TexteinstellungenGrafik;
with TextaccessverwaltungssystemGrafik;
with Diagnoseinformationen;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung).width,
                                                                                              GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      Feldgröße.x := Viewfläche.x / 7.00;
      Feldgröße.y := Viewfläche.y / 7.00;
      
      Diagnoseinformationen.Positionsinformationen (PositionExtern => Feldgröße);
      
      AktuellePosition := (0.00, 0.00);
      
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
               null;
               -- Muss mein für Schwarz überhaupt was zeichnen oder kann man das problemlos leer lassen? äöü
               -- ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => Feldgröße,
               --                                         PositionExtern  => AktuellePosition,
               --                                         FarbeExtern     => Sf.Graphics.Color.sfBlack);
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern     => StadtSpeziesNummerExtern.Spezies)
            then
               null;
               
            else
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                          YKoordinateExtern        => YAchseSchleifenwert,
                                                          XKoordinateExtern        => XAchseSchleifenwert)
               is
                  when True =>
                     FeldBewirtschaftet := True;
               
                  when False =>
                     FeldBewirtschaftet := False;
               end case;
            
               DarstellungUmgebung (KarteKoordinatenExtern   => KartenWert,
                                    PositionExtern           => AktuellePosition,
                                    StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                    BewirtschaftetExtern     => FeldBewirtschaftet);
            end if;
            
            AktuellePosition.x := AktuellePosition.x + Feldgröße.x;
            
         end loop XAchseSchleife;
         
         AktuellePosition := (0.00, AktuellePosition.y + Feldgröße.y);
         
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
      Rahmendicke := (Feldgröße.y / 20.00 + Feldgröße.x / 20.00) / 2.00;
      
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
                                         PositionExtern    => (PositionExtern.x + Rahmendicke, PositionExtern.y + Rahmendicke),
                                         SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
               
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
                                            GrößeExtern       => (Feldgröße.x - 2.00 * Rahmendicke, Feldgröße.y - 2.00 * Rahmendicke),
                                            RahmendickeExtern => Rahmendicke);
      
   end DarstellungUmgebung;
   
   
   
   -- Skalierungskonstante einbauen. äöü
   -- Nicht nur hier sondern auch allgemein. äöü
   procedure Wirtschaftsinformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      TextaccessverwaltungssystemGrafik.Farbe (TextaccessExtern => TextaccessVariablen.TextAccess,
                                               FarbeExtern      => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
        
      ProduktionSchleife:
      for ProduktionSchleifenwert in 1 .. 4 loop
         
         case
           ProduktionSchleifenwert
         is
            when 1 =>
               Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
                                                                                                                           SpeziesExtern     => SpeziesExtern)'Wide_Wide_Image;
               
            when 2 =>
               Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                    SpeziesExtern     => SpeziesExtern)'Wide_Wide_Image;
               
            when 3 =>
               Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                                                                                        SpeziesExtern     => SpeziesExtern)'Wide_Wide_Image;
               
            when 4 =>
               Text := Meldungstexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                                                                                             SpeziesExtern     => SpeziesExtern)'Wide_Wide_Image;
         end case;
         
         TextaccessverwaltungssystemGrafik.TextPosition (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                         TextExtern       => To_Wide_Wide_String (Source => Text),
                                                         PositionExtern   => (PositionExtern.x, (Feldgröße.y / 5.00) * Float (ProduktionSchleifenwert - 1) + PositionExtern.y));
         
         Textfläche := (Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).width, Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).height);
         
         if
           Textfläche.x >= Feldgröße.x - 3.00 * Rahmendicke
         then
            Skalierung.x := (Feldgröße.x - 3.00 * Rahmendicke) / Textfläche.x;
            
         else
            Skalierung.x := Textfläche.x / (Feldgröße.x - 3.00 * Rahmendicke);
         end if;
         
         if
           Textfläche.y >= (Feldgröße.y - Rahmendicke) / 5.00
         then
            Skalierung.y := (Feldgröße.y - Rahmendicke) / 5.00 / Textfläche.y;
            
         else
            Skalierung.y := Textfläche.y / (Feldgröße.y - Rahmendicke);
         end if;
                  
         TextaccessverwaltungssystemGrafik.SkalierenZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                              SkalierungExtern => Skalierung);
         
      end loop ProduktionSchleife;
      
      TextaccessverwaltungssystemGrafik.Skalieren (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                   SkalierungExtern => (1.00, 1.00));
      
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
      
      FeldeffektZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (Gesamtgrund.Basisgrund),
                                                                PositionExtern     => PositionExtern,
                                                                GrößeExtern        => Feldgröße);
        
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (Gesamtgrund.Zusatzgrund),
                                                                      PositionExtern     => PositionExtern,
                                                                      GrößeExtern        => Feldgröße);
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
                                                                      PositionExtern     => PositionExtern,
                                                                      GrößeExtern        => Feldgröße);
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
                                                                      PositionExtern     => PositionExtern,
                                                                      GrößeExtern        => Feldgröße);
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
                                                                      PositionExtern     => PositionExtern,
                                                                      GrößeExtern        => Feldgröße);
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
                                                                      PositionExtern     => PositionExtern,
                                                                      GrößeExtern        => Feldgröße);
      end case;
      
   end VerbesserungZeichnen;
   
   
   
   procedure FeldeffektZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EffekteSchleife:
      for EffektSchleifenwert in KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => EffektSchleifenwert)
         is
            when True =>
               KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.FeldeffekteAccess (EffektSchleifenwert),
                                                                         PositionExtern     => PositionExtern,
                                                                         GrößeExtern        => Feldgröße);
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
   end FeldeffektZeichnen;

end StadtumgebungGrafik;
