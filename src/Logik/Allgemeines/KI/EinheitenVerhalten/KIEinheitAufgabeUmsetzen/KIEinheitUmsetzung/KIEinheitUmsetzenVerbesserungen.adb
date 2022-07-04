pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;

with Aufgaben;
with Fehler;

package body KIEinheitUmsetzenVerbesserungen is

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      WelcheVerbesserung := LeseEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => EinheitKoordinaten);
      
      ------------------------------------- Verhindert das Verbinden von Städten mit Straßen und weiteres. Später eine bessere Lösung bauen.
      if
        LeseKarten.RasseBelegtGrund (KoordinatenExtern => EinheitKoordinaten) /= EinheitRasseNummerExtern.Rasse
      then
         return False;
         
      else
         null;
      end if;
      
      ------------------------------------- Aufgaben muss dringend überarbeitet werden.
      ------------------------------------- Diese ganze Aufteilung zwischen AufgabenDatentypen, TastenbelegungDatentypen und KartenVerbesserungDatentypen muss mal verbessert werden.
      case
        WelcheVerbesserung
      is
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Mine_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenVerbesserungDatentypen.Mine_Enum
            then
               return False;
               
            elsif
              True = Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Mine_Bauen_Enum)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Farm_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenVerbesserungDatentypen.Farm_Enum
            then
               return False;
               
            elsif
              True = Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Farm_Bauen_Enum)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Festung_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenVerbesserungDatentypen.Festung_Enum
            then
               return False;
               
            elsif
              True = Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Festung_Bauen_Enum)
            then
               null;
               
            else
               return False;
            end if;
            
         when AufgabenDatentypen.Straße_Bauen_Enum =>
            Befehl := TastenbelegungDatentypen.Straße_Bauen_Enum;
            
            if
              True = Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BefehlExtern             => TastenbelegungDatentypen.Straße_Bauen_Enum)
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIEinheitUmsetzenVerbesserungen.WelcheVerbesserungAnlegen - Falsche Verbesserung ausgewählt.");
            return False;
      end case;
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => Befehl);
      
   end WelcheVerbesserungAnlegen;

end KIEinheitUmsetzenVerbesserungen;
