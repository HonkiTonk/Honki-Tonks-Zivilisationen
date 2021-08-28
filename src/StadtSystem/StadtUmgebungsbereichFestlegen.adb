pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut, LeseWichtiges;

package body StadtUmgebungsbereichFestlegen is

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when GlobaleDatentypen.Leer =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            null;
            
         when others =>
            StadtUmgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtUmgebungsbereichFestlegen;
   
   
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Endwert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Endwert, StadtRasseNummerExtern.Rasse)
      then
         SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              UmgebungGrößeExtern    => 3,
                                              ÄndernSetzenExtern     => False);
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Anfangswert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse)
      then
         SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              UmgebungGrößeExtern    => 2,
                                              ÄndernSetzenExtern     => False);       
                  
      else
         SchreibeStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              UmgebungGrößeExtern    => 1,
                                              ÄndernSetzenExtern     => False);
      end if;
      
   end StadtUmgebungErmitteln;

end StadtUmgebungsbereichFestlegen;
