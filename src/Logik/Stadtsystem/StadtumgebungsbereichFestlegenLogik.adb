pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Fehler;
with ForschugnstestsLogik;

package body StadtumgebungsbereichFestlegenLogik is

   procedure StadtumgebungsbereichFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            Fehler.LogikFehler (FehlermeldungExtern => "StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen - Keine Rasse ausgewählt.");
            
         when others =>
            StadtumgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtumgebungsbereichFestlegen;
   
   
   
   procedure StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Einwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                      EinwohnerArbeiterExtern => True);
      
      if
        True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                          TechnologieExtern => TechnologieUmgebungsgröße (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse))
        and
          Einwohner >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 3;
         
      elsif
        True = ForschugnstestsLogik.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                          TechnologieExtern => TechnologieUmgebungsgröße (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse))
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
      
   end StadtumgebungErmitteln;

end StadtumgebungsbereichFestlegenLogik;
