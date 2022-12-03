with KartenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;

with Diagnoseinformationen;

package body EinheitenbewegungsbereichLogik is

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      VorhandeneBewegungspunkte := Positive (LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      AktuelleKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Bewegungsbereich := (others => (others => (others => False)));
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            else
               if
                 YAchseSchleifenwert <= 0
                 and
                   XAchseSchleifenwert >= 0
               then
                  QuadrantEins (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                KoordinatenExtern               => AktuelleKoordinaten,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => 0,
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
                  
               else
                  null;
               end if;
               
               if
                 YAchseSchleifenwert >= 0
                 and
                   XAchseSchleifenwert >= 0
               then
                  QuadrantZwei (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                KoordinatenExtern               => AktuelleKoordinaten,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => 0,
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
                  
               else
                  null;
               end if;
               
               if
                 YAchseSchleifenwert >= 0
                 and
                   XAchseSchleifenwert <= 0
               then
                  QuadrantDrei (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                KoordinatenExtern               => AktuelleKoordinaten,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => 0,
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
                  
               else
                  null;
               end if;
               
               if
                 YAchseSchleifenwert <= 0
                 and
                   XAchseSchleifenwert <= 0
               then
                  QuadrantVier (BewegungsfeldExtern             => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                KoordinatenExtern               => AktuelleKoordinaten,
                                EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                                NotwendigeBewegungspunkteExtern => 0,
                                VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkte);
                  
               else
                  null;
               end if;
            end if;
         
         end loop XAchseSchleife;
         
         Diagnoseinformationen.Zahl (ZahlExtern => 1);
         
      end loop YAchseSchleife;
      
   end BewegungsbereichBerechnen;
   
   
   
   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      if
        NeueKoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse
      then
         return False;
      
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => NeueKoordinatenExtern)
      then
         return False;
         
      elsif
        StadtKonstanten.LeerRasse /= StadtSuchenLogik.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                KoordinatenExtern => NeueKoordinatenExtern).Rasse
      then
         return False;
         
      elsif
        EinheitenKonstanten.LeerRasse /= EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeueKoordinatenExtern,
                                                                                               LogikGrafikExtern => True).Rasse
      then
         return False;
               
      elsif
        VorhandeneBewegungspunkteExtern < NotwendigeBewegungspunkteExtern + Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => NeueKoordinatenExtern,
                                                                                                                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;
         
      else
         return True;
      end if;
      
   end FeldPrüfen;
   
   
   
   procedure QuadrantEins
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      KartenwertQuadrantEins := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                            LogikGrafikExtern => True);
      
      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantEins,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;
            
         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantEins,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantEins.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;
            
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. 0 loop
         XAchseSchleife:
         for XAchseSchleifenwert in 0 .. KartenDatentypen.UmgebungsbereichEins'Last loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
                  
            else
               QuadrantEins (BewegungsfeldExtern             => (KartenwertQuadrantEins.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                             KoordinatenExtern               => KoordinatenExtern,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end QuadrantEins;
   
   
   
   procedure QuadrantZwei
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      KartenwertQuadrantZwei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                            LogikGrafikExtern => True);
            
      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantZwei,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;
            
         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantZwei,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantZwei.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;
            
      YAchseSchleife:
      for YAchseSchleifenwert in 0 .. KartenDatentypen.UmgebungsbereichEins'Last loop
         XAchseSchleife:
         for XAchseSchleifenwert in 0 .. KartenDatentypen.UmgebungsbereichEins'Last loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
                  
            else
               QuadrantZwei (BewegungsfeldExtern             => (KartenwertQuadrantZwei.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                             KoordinatenExtern               => KoordinatenExtern,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end QuadrantZwei;
   
   
   
   procedure QuadrantDrei
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      KartenwertQuadrantDrei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                            LogikGrafikExtern => True);
            
      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantDrei,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;
            
         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantDrei,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantDrei.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in 0 .. KartenDatentypen.UmgebungsbereichEins'Last loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. 0 loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
                  
            else
               QuadrantDrei (BewegungsfeldExtern             => (KartenwertQuadrantDrei.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                             KoordinatenExtern               => KoordinatenExtern,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end QuadrantDrei;
   
   
   
   procedure QuadrantVier
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
   is begin
      
      KartenwertQuadrantVier := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse),
                                                                                                            LogikGrafikExtern => True);
            
      case
        FeldPrüfen (NeueKoordinatenExtern           => KartenwertQuadrantVier,
                     EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                     NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern,
                     VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern)
      is
         when False =>
            return;
            
         when True =>
            ZusätzlicheBewegungspunkte := Positive (BewegungspunkteBerechnenLogik.NotwendigeBewegungspunkte (NeueKoordinatenExtern    => KartenwertQuadrantVier,
                                                                                                              EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            Bewegungsbereich (KartenwertQuadrantVier.EAchse, BewegungsfeldExtern.YAchse, BewegungsfeldExtern.XAchse) := True;
      end case;
            
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. 0 loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'First .. 0 loop
            
            if
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              BewegungsfeldExtern.YAchse + YAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
              or
                BewegungsfeldExtern.XAchse + XAchseSchleifenwert not in KartenDatentypen.Bewegungsbereich'Range
            then
               null;
                  
            else
               QuadrantVier (BewegungsfeldExtern             => (KartenwertQuadrantVier.EAchse, BewegungsfeldExtern.YAchse + YAchseSchleifenwert, BewegungsfeldExtern.XAchse + XAchseSchleifenwert),
                             KoordinatenExtern               => KoordinatenExtern,
                             EinheitRasseNummerExtern        => EinheitRasseNummerExtern,
                             NotwendigeBewegungspunkteExtern => NotwendigeBewegungspunkteExtern + ZusätzlicheBewegungspunkte,
                             VorhandeneBewegungspunkteExtern => VorhandeneBewegungspunkteExtern);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end QuadrantVier;

end EinheitenbewegungsbereichLogik;
