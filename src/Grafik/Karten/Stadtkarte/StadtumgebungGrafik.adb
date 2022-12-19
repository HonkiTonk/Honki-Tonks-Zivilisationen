with KartenDatentypen;
with Views;
with KartengrundDatentypen;
with ViewKonstanten;

with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Viewfläche := (7.00 * SichtweitenGrafik.KartenfelderAbmessung.x, 7.00 * SichtweitenGrafik.KartenfelderAbmessung.y);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
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
                                              RasseExtern       => StadtRasseNummerExtern.Rasse)
            then
               null;
               
            else
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
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
                                    StadtRasseNummerExtern => StadtRasseNummerExtern,
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
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
   is
      use type StadtRecords.RasseStadtnummerRecord;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      Grundbelegung := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KarteKoordinatenExtern);
      
      if
        Grundbelegung.Rasse = StadtKonstanten.LeerRasse
      then
         return;
        
      elsif
        Grundbelegung = StadtRasseNummerExtern
      then
         case
           BewirtschaftetExtern
         is
            when True =>
               Farbe := Sf.Graphics.Color.sfGreen;
               
            when False =>
               Farbe := Sf.Graphics.Color.sfBlue;
         end case;
            
      elsif
        Grundbelegung.Rasse = StadtRasseNummerExtern.Rasse
      then
         Farbe := Sf.Graphics.Color.sfCyan;
         
      else
         Farbe := Sf.Graphics.Color.sfRed;
      end if;
         
      Rahmendicke := (SichtweitenGrafik.KartenfelderAbmessung.y / 20.00 + SichtweitenGrafik.KartenfelderAbmessung.x / 20.00) / 2.00;
      
      ObjekteZeichnenGrafik.RahmenZeichnen (PositionExtern    => (PositionExtern.x + Rahmendicke, PositionExtern.y + Rahmendicke),
                                            FarbeExtern       => Farbe,
                                            GrößeExtern       => (SichtweitenGrafik.KartenfelderAbmessung.x - 2.00 * Rahmendicke, SichtweitenGrafik.KartenfelderAbmessung.y - 2.00 * Rahmendicke),
                                            RahmendickeExtern => Rahmendicke);
               
   end DarstellungUmgebung;
   
   
   
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
