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
with SpezieseinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;
with SichtweitenGrafik;
with NachGrafiktask;
with EinheitenbewegungsbereichLogik;

package body WeltkarteZeichnenGrafik is
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
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
                      EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                      PositionExtern           => PositionExtern);
      
      if
        NachGrafiktask.EinheitBewegungsbereich
        and
          (NachGrafiktask.Einheitenbewegung = False)
        and
          EinheitSpeziesNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
      then
         AnzeigeBewegungsfeld (KoordinatenExtern        => KoordinatenExtern,
                               PositionExtern           => PositionExtern);
         
      else
         null;
      end if;
      
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
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                  LogikGrafikExtern => False);
      
      if
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
        and
          EinheitSpeziesNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
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
                                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    PositionExtern           => PositionExtern);
         end case;
         
         return;
         
      elsif
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return;
         
      elsif
        EinheitSpeziesNummerExtern.Spezies /= EinheitSpeziesNummer.Spezies
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
                                                         
                                                         PositionExtern         => PositionExtern,
                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         return;
         
      else
         null;
      end if;
      
      if
        EinheitSpeziesNummer.Nummer = EinheitSpeziesNummerExtern.Nummer
      then
         null;
         
      elsif
        True = EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitSpeziesNummer,
                                                           LadungsnummerExtern => EinheitSpeziesNummerExtern.Nummer)
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
      else
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
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
         AusgewählteEinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
      case
        AusgewählteEinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummerExtern.Spezies, AusgewählteEinheitID),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
            
   end AnzeigeEinheit;
   
   
   
   -- Anstelle des Rahmens später vielleicht eine bessere Markierung ausdenken? äöü
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                            SpeziesExtern          => EinheitSpeziesNummerExtern.Spezies);
            
         end loop RahmenSchleife;
         
      else
         null;
      end if;
      
   end Einheitenmarkierung;
     
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleSpezies := LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleSpezies
      is
         when SpeziesDatentypen.Keine_Spezies_Enum =>
            null;
            
         when others =>
            RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                                 PositionExtern    => PositionExtern,
                                 SpeziesExtern       => AktuelleSpezies);
      end case;
            
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => PositionExtern,
                                                FarbeExtern    => SpezieseinstellungenGrafik.Speziesfarben (SpeziesExtern),
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
                            SpeziesExtern          => SpeziesExtern);
                     
         elsif
           SpeziesExtern /= LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => KartenWertRahmen)
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            SpeziesExtern          => SpeziesExtern);

         else
            null;
         end if;
            
      end loop UmgebungSchleife;
      
   end RahmenBesetztesFeld;



   procedure RahmenZeichnen
     (WelcheRichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
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
                                                FarbeExtern    => SpezieseinstellungenGrafik.SpeziesfarbenRahmen (SpeziesExtern),
                                                GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern);
      
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
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummer)));
      
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
   
   
   
   procedure AnzeigeBewegungsfeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      case
        EinheitenbewegungsbereichLogik.Bewegungsbereich (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse)
      is
         when False =>
            null;
            
         when True =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.KartenfelderAbmessung,
                                                    PositionExtern  => PositionExtern,
                                                    FarbeExtern     => (255, 255, 255, GrafikKonstanten.Bewegungsfeldtransparents));
      end case;
        
   end AnzeigeBewegungsfeld;

end WeltkarteZeichnenGrafik;
