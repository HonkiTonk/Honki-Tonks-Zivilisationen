pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with SystemDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with StadtEntfernen;
with KampfwerteStadtErmitteln;
with KampfwerteEinheitErmitteln;
with KampfsystemEinheiten;
with ZufallsgeneratorenKampf;
with StadtWerteFestlegen;
with StadtMeldungenSetzen;
with EinheitenErzeugenEntfernen;

package body KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      KampfwerteVerteidiger.Verteidigung := KampfwerteStadtErmitteln.AktuelleVerteidigungStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      KampfwerteVerteidiger.Angriff := KampfwerteStadtErmitteln.AktuellerAngriffStadt (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                                  AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                                                                                         AngreiferExtern          => True);
      
      -- Arbeiter nur halb anrechnen?
      GesundheitStadt := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                            EinwohnerArbeiterExtern => True);
      
      return Kampf (AngreifendeEinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern,
                    VerteidigendeStadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
      
   end KampfsystemStadt;
   
   
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
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
                                           EinwohnerArbeiterExtern => True) - 1
        <= StadtKonstanten.LeerStadt.EinwohnerArbeiter (1)
      then
         StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
         return True;
         
      else
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                            StadtRasseNummerExtern   => VerteidigendeStadtRasseNummerExtern);
         StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern,
                                                          EreignisExtern         => EinheitStadtDatentypen.Einwohner_Reduktion_Enum);
         if
           LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                              EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
           or
             LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => VerteidigendeStadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => True)
           = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, VerteidigendeStadtRasseNummerExtern.Rasse) - 1
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => VerteidigendeStadtRasseNummerExtern);
            
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
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      KampfSchleife:
      loop
         
         SchadenStadtBerechnen (AngriffExtern      => KampfwerteAngreifer.Angriff,
                                VerteidigungExtern => KampfwerteVerteidiger.Verteidigung);

         if
           GesundheitStadt <= 0
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
         
         KampfsystemEinheiten.KampfBerechnung (VerteidigerExtern  => AngreifendeEinheitRasseNummerExtern,
                                               AngriffExtern      => KampfwerteVerteidiger.Angriff,
                                               VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
         then
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => AngreifendeEinheitRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampfverlauf;
   
   
   
   procedure SchadenStadtBerechnen
     (AngriffExtern : in EinheitStadtDatentypen.Kampfwerte;
      VerteidigungExtern : in EinheitStadtDatentypen.Kampfwerte)
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
      
      Kampfglück := ZufallsgeneratorenKampf.KampfErfolg;
      AngerichteterSchaden := 0;
      
      AngerichteterSchadenSchleife:
      for AngerichteterSchadenSchleifenwert in reverse SchadenAngerichtetArray'Range (2) loop
         
         if
           Kampfglück >= SchadenAngerichtet (WelcherFall, AngerichteterSchadenSchleifenwert)
         then
            AngerichteterSchaden := AngerichteterSchaden + AngerichteterSchadenSchleifenwert;
            exit AngerichteterSchadenSchleife;
            
         else
            null;
         end if;
              
      end loop AngerichteterSchadenSchleife;
      
      if
        GesundheitStadt - AngerichteterSchaden < ProduktionDatentypen.ProduktionFeld'First
      then
         GesundheitStadt := 0;
         
      else
         GesundheitStadt := GesundheitStadt - AngerichteterSchaden;
      end if;
      
   end SchadenStadtBerechnen;

end KampfsystemStadt;
