with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen, Anzeige;
use GlobaleDatentypen;

package VerbesserungenDatenbank is

   type VerbesserungObjekt is record

      Anzeige : Wide_Wide_Character;
      
      Passierbarkeit : GlobaleDatentypen.PassierbarkeitType; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                                             -- Addieren für genaue Passierbarkeit

      Nahrungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Ressourcenbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Geldbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      Wissensbonus : GlobaleDatentypen.GrundwerteNRGWVA;

      Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
      
   end record;
   
   type VerbesserungObjektListeArray is array (GlobaleDatentypen.KartenVerbesserung'Range) of VerbesserungObjekt;
   VerbesserungObjektListe : VerbesserungObjektListeArray := ((' ', 13,    0, 0, 0, 0,    0), -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                              ('♣', 13,    0, 0, 0, 0,    3), -- 1 Eigene Hauptstadt
                                                              ('♠', 13,    0, 0, 0, 0,    2), -- 2 Eigene Stadt
                                                              ('⌂', 13,    0, 0, 0, 0,    3), -- 3 Andere Hauptstadt
                                                              ('¤', 13,    0, 0, 0, 0,    2), -- 4 Andere Stadt
                                                              ('╬', 13,    0, 0, 1, 0,    0), -- 5 Straßenkreuzung
                                                              ('═', 13,    0, 0, 1, 0,    0), -- 6 Straße waagrecht
                                                              ('║', 13,    0, 0, 1, 0,    0), -- 7 Straße senkrecht
                                                              ('╔', 13,    0, 0, 1, 0,    0), -- 8 Straßenkurve
                                                              ('╗', 13,    0, 0, 1, 0,    0), -- 9 Straßenkurve

                                                              ('╚', 13,    0, 0, 1, 0,    0), -- 10 Straßenkurve
                                                              ('╝', 13,    0, 0, 1, 0,    0), -- 11 Straßenkurve
                                                              ('╩', 13,    0, 0, 1, 0,    0), -- 12 Straßenkreuzung
                                                              ('╦', 13,    0, 0, 1, 0,    0), -- 13 Straßenkreuzung

                                                              ('╠', 13,    0, 0, 1, 0,    0), -- 14 Straßenkreuzung
                                               
                                                              ('╣', 13,    0, 0, 1, 0,    0), -- 15 Straßenkreuzung
                                                              ('╞', 13,    0, 0, 1, 0,    0), -- 16 Straßenendstück links
                                                              ('╡', 13,    0, 0, 1, 0,    0), -- 17 Straßenendstück rechts
                                                              ('╨', 13,    0, 0, 1, 0,    0), -- 18 Straßenendstück unten
                                                              ('╥', 13,    0, 0, 1, 0,    0), -- 19 Straßenendstück oben
                                                              ('F', 13,    2, 0, 1, 0,    1), -- 20 Farm
                                                              ('M', 13,    0, 2, 1, 0,    1), -- 21 Mine
                                                              ('B', 13,    0, 0, 0, 0,    2)); -- 22 Festung

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenVerbesserung) with
     Pre => ID > 0;
   
end VerbesserungenDatenbank;
