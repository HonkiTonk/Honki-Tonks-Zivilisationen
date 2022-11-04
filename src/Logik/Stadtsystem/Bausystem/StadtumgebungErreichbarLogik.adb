pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitSuchenLogik;

package body StadtumgebungErreichbarLogik is
   
   function UmgebungErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      GefundeneFelder := 1;
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YAchseSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XAchseSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                 
               elsif
                 BereitsGetestet >= abs (YAchseSchleifenwert)
                 and
                   BereitsGetestet >= abs (XAchseSchleifenwert)
               then
                  null;
                  
               elsif
                 True = LeseWeltkarte.BelegterGrund (RasseExtern       => RasseExtern,
                                                     KoordinatenExtern => KartenWert)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                                                          LogikGrafikExtern => True).Nummer
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern                => RasseExtern,
                                                                                IDExtern                   => IDExtern,
                                                                                NeueKoordinatenExtern      => KartenWert,
                                                                                StadtBerücksichtigenExtern => True)
                 and
                   True = NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                          RasseExtern               => RasseExtern,
                                          IDExtern                  => IDExtern)
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 True = LeseWeltkarte.BelegterGrund (RasseExtern       => RasseExtern,
                                                     KoordinatenExtern => KartenWert)
                 and
                   EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                                                          LogikGrafikExtern => True).Nummer
                 and
                   True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern                => RasseExtern,
                                                                                IDExtern                   => IDExtern,
                                                                                NeueKoordinatenExtern      => KartenWert,
                                                                                StadtBerücksichtigenExtern => True)
                 and
                   True = NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                          RasseExtern               => RasseExtern,
                                          IDExtern                  => IDExtern)
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         if
           Umgebung = KartenDatentypen.UmgebungsbereichDrei'Last
         then
            exit BereichSchleife;
         
         else
            Umgebung := Umgebung + 1;
            BereitsGetestet := Umgebung - 1;
         end if;
                     
      end loop BereichSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end UmgebungErreichbar;
   
   
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWertZwei := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                          ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                          LogikGrafikExtern => True);
            
            if
              KartenWertZwei.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              True = LeseWeltkarte.BelegterGrund (RasseExtern       => RasseExtern,
                                                  KoordinatenExtern => KartenWertZwei)
              and
                True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern                => RasseExtern,
                                                                             IDExtern                   => IDExtern,
                                                                             NeueKoordinatenExtern      => KartenWertZwei,
                                                                             StadtBerücksichtigenExtern => True)
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
        
   end NochErreichbar;

end StadtumgebungErreichbarLogik;
