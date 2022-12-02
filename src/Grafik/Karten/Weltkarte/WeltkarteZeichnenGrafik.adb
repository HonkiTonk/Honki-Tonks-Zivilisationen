with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenKonstanten;
with TextaccessVariablen;
with ZeitKonstanten;
with KartenKonstanten;
with GrafikKonstanten;
with KartengrundDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseStadtGebaut;

with EinheitSuchenLogik;
with StadtSuchenLogik;
with ObjekteZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with TextberechnungenBreiteGrafik;
with RasseneinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;
with SichtweitenGrafik;
with NachGrafiktask;

package body WeltkarteZeichnenGrafik is
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern      => KoordinatenExtern,
                          PositionExtern         => PositionExtern,
                          DurchsichtigkeitExtern => TransparentsExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            EbeneExtern       => EbeneExtern,
                            PositionExtern    => PositionExtern);
      
      AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
      
      AnzeigeEinheit (KoordinatenExtern        => KoordinatenExtern,
                      EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                      PositionExtern           => PositionExtern);
      
   end EbeneZeichnen;
   
   

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.BasisgrundAccess (Gesamtgrund.Basisgrund),
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.ZusatzgrundAccess (Gesamtgrund.Zusatzgrund),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => DurchsichtigkeitExtern);
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
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenflussAccess (KartenfeldFluss),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
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
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenressourceAccess (KartenfeldRessource),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
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
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
            if
              KoordinatenExtern.EAchse = EbeneExtern
            then
               StadtnameAnzeigen (KoordinatenExtern => KoordinatenExtern,
                                  PositionExtern    => PositionExtern);
               
            else
               null;
            end if;
               
         when others =>
            null;
      end case;
      
      KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      
   end VerbesserungZeichnen;
   
   
   
   -- Das hier noch einmal überarbeiten. äöü
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      EinheitRasseNummer := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                  LogikGrafikExtern => False);
      
      if
        EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
        and
          EinheitRasseNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
      then
         if
           Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
         then
            AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
            StartzeitBlinkintervall := Clock;
            
         else
            null;
         end if;
         
         case
           AusgewählteEinheitAnzeigen
         is
            when False =>
               null;
               
            when True =>
               Einheitenmarkierung (KoordinatenExtern        => KoordinatenExtern,
                                    EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    PositionExtern           => PositionExtern);
         end case;
         
         return;
         
      elsif
        EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return;
         
      elsif
        EinheitRasseNummerExtern.Rasse /= EinheitRasseNummer.Rasse
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
         
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitRasseNummer.Rasse, FeldeinheitID),
                                                         
                                                         PositionExtern         => PositionExtern,
                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         return;
         
      else
         null;
      end if;
      
      if
        EinheitRasseNummer.Nummer = EinheitRasseNummerExtern.Nummer
      then
         null;
         
      elsif
        True = EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitRasseNummer,
                                                           LadungsnummerExtern => EinheitRasseNummerExtern.Nummer)
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitRasseNummer.Rasse, FeldeinheitID),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
      else
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitRasseNummer.Rasse, FeldeinheitID),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
         return;
      end if;
      
      if
        Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
      then
         AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
         StartzeitBlinkintervall := Clock;
            
      else
         null;
      end if;
      
      if
        AusgewählteEinheitAnzeigen = False
        and
          NachGrafiktask.Einheitenbewegung = False
      then
         return;
               
      else
         AusgewählteEinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      case
        AusgewählteEinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitRasseNummerExtern.Rasse, AusgewählteEinheitID),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
            
   end AnzeigeEinheit;
   
   
   
   -- Anstelle des Rahmens später vielleicht eine bessere Markierung ausdenken? äöü
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        KoordinatenExtern.EAchse /= EinheitKoordinaten.EAchse
        and
          KoordinatenExtern.YAchse = EinheitKoordinaten.YAchse
          and
            KoordinatenExtern.XAchse = EinheitKoordinaten.XAchse
      then
         RahmenSchleife:
         for RahmenSchleifenwert in UmgebungArray'Range loop
            
            RahmenZeichnen (WelcheRichtungExtern => RahmenSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => EinheitRasseNummerExtern.Rasse);
            
         end loop RahmenSchleife;
         
      else
         null;
      end if;
      
   end Einheitenmarkierung;
     
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleRasse := LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleRasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            null;
            
         when others =>
            RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                                 PositionExtern    => PositionExtern,
                                 RasseExtern       => AktuelleRasse);
      end case;
            
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => PositionExtern,
                                                FarbeExtern    => RasseneinstellungenGrafik.Rassenfarben (RasseExtern),
                                                GrößeExtern    => SichtweitenGrafik.KartenfelderAbmessung);
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in UmgebungArray'Range loop
         
         KartenWertRahmen := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => Umgebung (UmgebungSchleifenwert),
                                                                                                         LogikGrafikExtern => False);
               
         if
           KartenWertRahmen.XAchse = KartenKonstanten.LeerXAchse
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);
                     
         elsif
           RasseExtern /= LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => KartenWertRahmen)
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);

         else
            null;
         end if;
            
      end loop UmgebungSchleife;
      
   end RahmenBesetztesFeld;



   procedure RahmenZeichnen
     (WelcheRichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      case
        WelcheRichtungExtern
      is
         when KartenartDatentypen.Norden_Enum =>
            Rahmengröße := (SichtweitenGrafik.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := PositionExtern;
         
         when KartenartDatentypen.Westen_Enum =>
            Rahmengröße := (DickeRahmen, SichtweitenGrafik.KartenfelderAbmessung.y);
            Rahmenposition := PositionExtern;
         
         when KartenartDatentypen.Osten_Enum =>
            Rahmengröße := (DickeRahmen, SichtweitenGrafik.KartenfelderAbmessung.y);
            Rahmenposition := (PositionExtern.x + SichtweitenGrafik.KartenfelderAbmessung.x - DickeRahmen, PositionExtern.y);
         
         when KartenartDatentypen.Süden_Enum =>
            Rahmengröße := (SichtweitenGrafik.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := (PositionExtern.x, PositionExtern.y + SichtweitenGrafik.KartenfelderAbmessung.y - DickeRahmen);
      end case;
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => Rahmenposition,
                                                FarbeExtern    => RasseneinstellungenGrafik.RassenfarbenRahmen (RasseExtern),
                                                GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      StadtRasseNummer := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                       color => Sf.Graphics.Color.sfBlack);
            
         when others =>
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                       color => Sf.Graphics.Color.sfWhite);
      end case;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      
      Sf.Graphics.Text.setScale (text  => TextaccessVariablen.KarteAccess,
                                 scale => (0.70, 0.70));
      
      Textposition.x := PositionExtern.x - TextberechnungenBreiteGrafik.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.KarteAccess) + 0.50 * SichtweitenGrafik.KartenfelderAbmessung.x;
      Textposition.y := PositionExtern.y - TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      -- Später noch einen Rahmen um den Namen bauen? äöü
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.KarteAccess);
      
   end StadtnameAnzeigen;

end WeltkarteZeichnenGrafik;
