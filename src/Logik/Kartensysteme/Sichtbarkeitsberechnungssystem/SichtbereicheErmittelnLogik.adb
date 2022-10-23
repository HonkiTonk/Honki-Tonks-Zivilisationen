pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body SichtbereicheErmittelnLogik is

   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
   is begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      if
        KoordinatenEinheit.EAchse >= KartenKonstanten.OberflächeKonstante
        and
          (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern             => EinheitID,
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
           or
             True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                           IDExtern             => EinheitID,
                                                           WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
      then
         return 3;
         
      else
         AktuellerGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenEinheit);
         BasisGrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenEinheit);
      end if;
      
      -- Das hier später erweitern, beispielsweise im Dschungel auf dem Berg kürzere Sichtweite ermitteln. äöü
      -- Oder auch einheitenspezifische Eigenschaften berücksichtigen. äöü
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
      then
         return 3;

      elsif
        AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
          or
            AktuellerGrund = KartengrundDatentypen.Wald_Enum
      then
         return 1;
               
      else
         return 2;
      end if;
      
   end SichtweiteErmitteln;
   
   
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is begin
      
      KartenBlockadeWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YÄnderungExtern, XÄnderungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenBlockadeWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
         
         when others =>
            AktuellerGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
            BasisGrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
      end case;
         
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
      then
         null;
         
      elsif
        SichtweiteExtern /= 3
        and
          (AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
           or
             AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
           or
             AktuellerGrund = KartengrundDatentypen.Wald_Enum)
      then
         null;
         
      else
         return True;
      end if;
      
      return False;
            
   end SichtbarkeitBlockadeTesten;

end SichtbereicheErmittelnLogik;
