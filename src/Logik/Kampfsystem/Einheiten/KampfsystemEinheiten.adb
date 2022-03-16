pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with ZufallGeneratorenKampf;
with KampfwerteEinheitErmitteln;
with EinheitenErzeugenEntfernen;

package body KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin

      KampfwerteVerteidiger.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                                    AngreiferExtern          => False);
      KampfwerteVerteidiger.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => VerteidigerExtern,
                                                                                           AngreiferExtern          => False);
      
      KampfwerteAngreifer.Verteidigung := KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                                  AngreiferExtern          => True);
      KampfwerteAngreifer.Angriff := KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => AngreiferExtern,
                                                                                         AngreiferExtern          => True);
      
      return Kampf (VerteidigerExtern => VerteidigerExtern,
                    AngreiferExtern   => AngreiferExtern);
      
   end KampfsystemNahkampf;



   function Kampf
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerExtern  => VerteidigerExtern,
                          AngriffExtern      => KampfwerteAngreifer.Angriff,
                          VerteidigungExtern => KampfwerteVerteidiger.Verteidigung);

         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => AngreiferExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => AngreiferExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => AngreiferExtern)),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerExtern  => AngreiferExtern,
                          AngriffExtern      => KampfwerteVerteidiger.Angriff,
                          VerteidigungExtern => KampfwerteAngreifer.Verteidigung);
         
         if
           LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => AngreiferExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
         then
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                                      ErfahrungspunkteExtern   => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => VerteidigerExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => VerteidigerExtern)),
                                                      AddierenSetzenExtern     => True);
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;
   


   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      -- Hier besser nicht den KampfwerteRecord verwenden, sonst komme ich noch durcheinander dass das ja zwei unterschiedliche Einheiten sind welche sich hier bekämpfen.
      AngriffExtern : in EinheitStadtDatentypen.Kampfwerte;
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
      
      Kampfglück := ZufallGeneratorenKampf.KampfErfolg;
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
      
      -- Den Schadensdatentyp abhängig von den Lebenspunkten machen? Oder ein anderes System bauen?
      SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => VerteidigerExtern,
                                            LebenspunkteExtern       => EinheitStadtDatentypen.Lebenspunkte (AngerichteterSchaden),
                                            RechnenSetzenExtern      => -1);
      
   end KampfBerechnung;

end KampfsystemEinheiten;
