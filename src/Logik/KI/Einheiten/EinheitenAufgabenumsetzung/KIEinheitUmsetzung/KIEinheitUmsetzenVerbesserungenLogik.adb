with LeseWeltkarte;
with LeseEinheitenGebaut;

with AufgabenLogik;
with Fehlermeldungssystem;

package body KIEinheitUmsetzenVerbesserungenLogik is

   function WelcheVerbesserungAnlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      WelcheVerbesserung := LeseEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      VorhandeneVerbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => EinheitKoordinaten);
      
      if
        LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => EinheitKoordinaten) /= EinheitSpeziesNummerExtern.Spezies
        and
          WelcheVerbesserung not in AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range
      then
         return False;
         
      else
         null;
      end if;
      
      -- Aufgaben muss dringend überarbeitet werden. äöü
      -- Diese ganze Aufteilung zwischen AufgabenDatentypen, TastenbelegungDatentypen und KartenverbesserungDatentypen muss mal verbessert werden. äöü
      case
        WelcheVerbesserung
      is
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            Befehl := BefehleDatentypen.Mine_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Mine_Enum
            then
               return False;
               
            else
               null;
            end if;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            Befehl := BefehleDatentypen.Farm_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Farm_Enum
            then
               return False;
               
            else
               null;
            end if;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            Befehl := BefehleDatentypen.Festung_Bauen_Enum;
            
            if
              VorhandeneVerbesserung = KartenverbesserungDatentypen.Festung_Enum
            then
               return False;
               
            else
               null;
            end if;
            
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            Befehl := BefehleDatentypen.Straße_Bauen_Enum;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "KIEinheitUmsetzenVerbesserungenLogik.WelcheVerbesserungAnlegen: Falsche Verbesserung: " & WelcheVerbesserung'Wide_Wide_Image);
            return False;
      end case;
      
      case
        AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                               BefehlExtern               => Befehl,
                               AnlegenTestenExtern        => False,
                               KoordinatenExtern          => EinheitKoordinaten)
      is
         when True =>
            return AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          BefehlExtern               => Befehl,
                                          AnlegenTestenExtern        => True,
                                          KoordinatenExtern          => EinheitKoordinaten);
               
         when False =>
            return False;
      end case;
            
   end WelcheVerbesserungAnlegen;

end KIEinheitUmsetzenVerbesserungenLogik;
