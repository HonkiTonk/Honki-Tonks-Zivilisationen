pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Fehler;
with ForschungAllgemein;

package body StadtUmgebungsbereichFestlegen is

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            Fehler.LogikFehler (FehlermeldungExtern => "StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen - Keine Rasse ausgewählt.");
            
         when others =>
            StadtUmgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtUmgebungsbereichFestlegen;
   
   
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Einwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                      EinwohnerArbeiterExtern => True);
      
      if
        True = ForschungAllgemein.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                        TechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, SystemDatentypen.Endwert_Enum))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 3;
         
      elsif
        True = ForschungAllgemein.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                        TechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, SystemDatentypen.Anfangswert_Enum))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 2;      
                  
      else
         Umgebung := 1;
      end if;
      
      SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           UmgebungGrößeExtern    => Umgebung,
                                           ÄndernSetzenExtern     => False);
      
   end StadtUmgebungErmitteln;

end StadtUmgebungsbereichFestlegen;
