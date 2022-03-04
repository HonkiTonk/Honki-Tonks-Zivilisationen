pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseWichtiges;

with Fehler;

package body StadtUmgebungsbereichFestlegen is

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            Fehler.LogikFehler (FehlermeldungExtern => "StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen - when StadtKonstanten.LeerRasse =>");
            
         when others =>
            StadtUmgebungErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end StadtUmgebungsbereichFestlegen;
   
   
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, SystemDatentypen.Endwert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert, StadtRasseNummerExtern.Rasse)
      then
         Umgebung := 3;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, SystemDatentypen.Anfangswert))
          = True
        and
          LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True)
        >= StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse)
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
