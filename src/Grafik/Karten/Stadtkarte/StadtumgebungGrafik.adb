pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with KartenKonstanten;
with Views;

with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with KartenberechnungenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with FarbgebungGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Viewfläche := (7.00 * KartenberechnungenGrafik.StadtfelderAbmessung.x, 7.00 * KartenberechnungenGrafik.StadtfelderAbmessung.y);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (2),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (2));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Viewfläche := (0.00, 0.00);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            if
              KartenWert.EAchse = KartenKonstanten.LeerEAchse
            then
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => KartenberechnungenGrafik.StadtfelderAbmessung,
                                                       PositionExtern       => Viewfläche,
                                                       FarbeExtern          => Sf.Graphics.Color.sfBlack);
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                           RasseExtern       => StadtRasseNummerExtern.Rasse)
            then
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => KartenberechnungenGrafik.StadtfelderAbmessung,
                                                       PositionExtern       => Viewfläche,
                                                       FarbeExtern          => Sf.Graphics.Color.sfBlack);
               
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
            
            Viewfläche.x := Viewfläche.x + KartenberechnungenGrafik.StadtfelderAbmessung.x;
            
         end loop XAchseSchleife;
         
         Viewfläche := (0.00, Viewfläche.y + KartenberechnungenGrafik.StadtfelderAbmessung.y);
         
      end loop YAchseSchleife;
      
   end Stadtumgebung;
   
   
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
   is begin
      
      AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      case
        LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              KoordinatenExtern      => KarteKoordinatenExtern)
      is
         when True =>
            if
              BewirtschaftetExtern
            then
               Farbe := Sf.Graphics.Color.sfGreen;
               
            else
               Farbe := Sf.Graphics.Color.sfRed;
            end if;
            
            -- Hier noch eine bessere Lösung bauen, damit die besetzbaren Felder immer zu erkennen sind. äöü
            -- Muss vermutlich Ebenenabhängig sein. äöü
            ObjekteZeichnenGrafik.RahmenZeichnen (PositionExtern    => (PositionExtern.x + 3.00, PositionExtern.y + 3.00),
                                                  FarbeExtern       => Farbe,
                                                  GrößeExtern       => (KartenberechnungenGrafik.StadtfelderAbmessung.x - 6.00, KartenberechnungenGrafik.StadtfelderAbmessung.y - 6.00),
                                                  RahmendickeExtern => 3.00);
            
         when False =>
            null;
      end case;
               
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
      
      Kartenfeld := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.KartenfelderAccess (Kartenfeld),
                                                               PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => KartenberechnungenGrafik.StadtfelderAbmessung,
                                                    PositionExtern       => PositionExtern,
                                                    FarbeExtern          => FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld));
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldFluss = KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.KartenflussAccess (KartenfeldFluss),
                                                                      PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => (KartenberechnungenGrafik.StadtfelderAbmessung.x, KartenberechnungenGrafik.StadtfelderAbmessung.y / 5.00),
                                                 PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * KartenberechnungenGrafik.StadtfelderAbmessung.y),
                                                 FarbeExtern          => Sf.Graphics.Color.sfBlue);
      end if;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.KartenressourceAccess (KartenfeldRessource),
                                                                      PositionExtern     => PositionExtern)
      then
         null;
         
      else
         ObjekteZeichnenGrafik.KreisZeichnen (RadiusExtern      => KartenberechnungenGrafik.StadtfelderAbmessung.x / 3.00,
                                              PositionExtern    => PositionExtern,
                                              FarbeExtern       => Sf.Graphics.Color.sfBlack);
      end if;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      if
        Wegfeld = KartenverbesserungDatentypen.Leer_Weg_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                                      PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => (KartenberechnungenGrafik.StadtfelderAbmessung.x, KartenberechnungenGrafik.StadtfelderAbmessung.y / 2.00),
                                                 PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * KartenberechnungenGrafik.StadtfelderAbmessung.y),
                                                 FarbeExtern          => Sf.Graphics.Color.sfRed);
      end if;
   
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      if
        Verbesserungsfeld = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenGrafik.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                                      PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern      => (KartenberechnungenGrafik.StadtfelderAbmessung.x / 2.00, KartenberechnungenGrafik.StadtfelderAbmessung.y / 2.00),
                                                 PositionExtern       => PositionExtern,
                                                 FarbeExtern          => Sf.Graphics.Color.sfCyan);
      end if;
      
   end VerbesserungZeichnen;

end StadtumgebungGrafik;
