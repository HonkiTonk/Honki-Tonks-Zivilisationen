with Sf.Graphics.Text;

with KartenDatentypen;
with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with TextaccessVariablen;
with Meldungstexte;
with SpeziesKonstanten;
with TextnummernKonstanten;
with GrafikRecordKonstanten;

with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenfelderwerteLogik;
with TexteinstellungenGrafik;
with TextaccessverwaltungssystemGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung),
                                            GrößeExtern          => (7.00 * SichtweitenGrafik.KartenfelderAbmessung.x, 7.00 * SichtweitenGrafik.KartenfelderAbmessung.y),
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.KartenfelderAbmessung,
                                                       PositionExtern  => AktuellePosition,
                                                       FarbeExtern     => Sf.Graphics.Color.sfBlack);
               
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
            
            AktuellePosition.x := AktuellePosition.x + SichtweitenGrafik.KartenfelderAbmessung.x;
            
         end loop XAchseSchleife;
         
         AktuellePosition := (0.00, AktuellePosition.y + SichtweitenGrafik.KartenfelderAbmessung.y);
         
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
                                                         PositionExtern   => (PositionExtern.x, (SichtweitenGrafik.KartenfelderAbmessung.y / 5.00) * Float (ProduktionSchleifenwert - 1) + PositionExtern.y));
         
         Textfläche := (Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).width, Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TextAccess).height);
         
         if
           Textfläche.x >= SichtweitenGrafik.KartenfelderAbmessung.x - 3.00 * Rahmendicke
         then
            Skalierung.x := (SichtweitenGrafik.KartenfelderAbmessung.x - 3.00 * Rahmendicke) / Textfläche.x;
            
         else
            Skalierung.x := Textfläche.x / (SichtweitenGrafik.KartenfelderAbmessung.x - 3.00 * Rahmendicke);
         end if;
         
         if
           Textfläche.y >= (SichtweitenGrafik.KartenfelderAbmessung.y - Rahmendicke) / 5.00
         then
            Skalierung.y := (SichtweitenGrafik.KartenfelderAbmessung.y - Rahmendicke) / 5.00 / Textfläche.y;
            
         else
            Skalierung.y := Textfläche.y / (SichtweitenGrafik.KartenfelderAbmessung.y - Rahmendicke);
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
                                                                         PositionExtern     => PositionExtern);
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
   end FeldeffektZeichnen;

end StadtumgebungGrafik;
