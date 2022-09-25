pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with SystemDatentypen;
with StadtDatentypen;
with KampfKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with StadtEntfernenLogik;
with KampfwerteStadtErmittelnLogik;
with KampfwerteEinheitErmittelnLogik;
with KampfsystemEinheitenLogik;
with ZufallsgeneratorenKampfLogik;
with StadtwerteFestlegenLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;

package body KampfsystemStadtLogik is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      KampfwerteVerteidiger.Verteidigung := KampfwerteStadtErmittelnLogik.AktuelleVerteidigungStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      KampfwerteVerteidiger.Angriff := KampfwerteStadtErmittelnLogik.AktuellerAngriffStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmittelnLogik.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                                       AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmittelnLogik.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                              AngreiferExtern          => True);
      
      -- Arbeiter nur halb anrechnen?
      GesundheitStadt := KampfDatentypen.Kampfwerte (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                                                        EinwohnerArbeiterExtern => True));
      
      return Kampf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                    VerteidigendeStadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
   end KampfsystemStadt;
   
   
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        Kampfverlauf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                           EinwohnerArbeiterExtern => True)
        - 1
        <= StadtKonstanten.LeerEinwohner
      then
         StadtEntfernenLogik.StadtEntfernen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
         return True;
         
      else
         StadtwerteFestlegenLogik.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => VerteidigendeStadtRasseNummerExtern);
         MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                                                          EreignisExtern         => StadtDatentypen.Einwohner_Reduktion_Enum);
         if
           LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                              EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
           or
             LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
         then
            StadtwerteFestlegenLogik.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
            
         else
            null;
         end if;
         
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => 1.50,
                                                  RechnenSetzenExtern      => -1);
         return False;
      end if;
      
   end Kampf;
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      KampfSchleife:
      loop
         
         GesundheitStadt := SchadenStadtBerechnen (AngriffExtern         => KampfwerteAngreifer.Angriff,
                                                   VerteidigungExtern    => KampfwerteVerteidiger.Verteidigung,
                                                   StadtgesundheitExtern => GesundheitStadt);

         if
           GesundheitStadt = 0
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreifendeEinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    =>
                                                                                                                                LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern)),
                                                      AddierenSetzenExtern     => True);
            return True;
            
         else
            null;
         end if;
         
         KampfsystemEinheitenLogik.KampfBerechnung (VerteidigerExtern  => AngreifendeEinheitRasseNummerExtern,
                                                    AngriffExtern      => KampfwerteVerteidiger.Angriff,
                                                    VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) = EinheitenKonstanten.LeerLebenspunkte
         then
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;
   
   
   
   function SchadenStadtBerechnen
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte;
      StadtgesundheitExtern : in KampfDatentypen.Kampfwerte)
      return KampfDatentypen.Kampfwerte
   is begin
      
      -- Bei Extremfällen AngerichteterSchaden schon vorher einen Wert geben?
      if
        AngriffExtern > 2 * VerteidigungExtern
      then
         WelcherFall := Extrem_Stärker_Enum;

      elsif
        AngriffExtern > VerteidigungExtern
      then
         WelcherFall := Stärker_Enum;

      elsif
        AngriffExtern < VerteidigungExtern
        and
          2 * AngriffExtern > VerteidigungExtern
      then
         WelcherFall := Schwächer_Enum;
         
      elsif
        2 * AngriffExtern < VerteidigungExtern
      then
         WelcherFall := Extrem_Schwächer_Enum;

      else
         WelcherFall := Gleich_Enum;
      end if;
      
      Kampfglück := ZufallsgeneratorenKampfLogik.KampfErfolg;
      AngerichteterSchaden := 0;
      
      AngerichteterSchadenSchleife:
      for AngerichteterSchadenSchleifenwert in reverse KampfKonstanten.SchadenAngerichtetArray'Range (2) loop
         
         if
           Kampfglück >= KampfKonstanten.SchadenAngerichtet (WelcherFall, AngerichteterSchadenSchleifenwert)
         then
            AngerichteterSchaden := AngerichteterSchaden + AngerichteterSchadenSchleifenwert;
            exit AngerichteterSchadenSchleife;
            
         else
            null;
         end if;
              
      end loop AngerichteterSchadenSchleife;
      
      if
        StadtgesundheitExtern - AngerichteterSchaden < KampfDatentypen.Kampfwerte'First
      then
         return 0;
         
      else
         return StadtgesundheitExtern - AngerichteterSchaden;
      end if;
      
   end SchadenStadtBerechnen;

end KampfsystemStadtLogik;
