with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Einlesen, GlobaleVariablen, Auswahl, EinheitenDatenbank, Karten, Fehlermeldungen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

package VerbesserungenDatenbank is

   type VerbesserungObjekt is record

      Anzeige : Wide_Wide_Character;
      
      Passierbarkeit : Integer; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                -- Addieren für genaue Passierbarkeit
      
   end record;
   
   type VerbesserungObjektListeArray is array (1 .. 22) of VerbesserungObjekt;
   VerbesserungObjektListe : VerbesserungObjektListeArray := (('♣', 13), -- 1 Eigene Hauptstadt -- Hier noch Symbole (wieder) einfügen
                                                              ('♠', 13), -- 2 Eigene Stadt
                                                              ('⌂', 13), -- 3 Andere Hauptstadt
                                                              ('¤', 13), -- 4 Andere Stadt
                                                              ('╬', 13), -- 5 Straßenkreuzung
                                                              ('═', 13), -- 6 Straße waagrecht
                                                              ('║', 13), -- 7 Straße senkrecht
                                                              ('╔', 13), -- 8 Straßenkurve
                                                              ('╗', 13), -- 9 Straßenkurve

                                                              ('╚', 13), -- 10 Straßenkurve
                                                              ('╝', 13), -- 11 Straßenkurve
                                                              ('╩', 13), -- 12 Straßenkreuzung
                                                              ('╦', 13), -- 13 Straßenkreuzung

                                                              ('╠', 13), -- 14 Straßenkreuzung
                                               
                                                              ('╣', 13), -- 15 Straßenkreuzung
                                                              ('╞', 13), -- 16 Straßenendstück rechts
                                                              ('╡', 13), -- 17 Straßenendstück links
                                                              ('╨', 13), -- 18 Straßenendstück oben
                                                              ('╥', 13), -- 19 Straßenendstück unten
                                                              ('F', 13), -- 20 Farm
                                                              ('M', 13), -- 21 Mine
                                                              ('B', 13)); -- 22 Festung

   procedure Beschreibung (ID : in Integer);
   procedure Verbesserung (Befehl : in Wide_Wide_Character; Rasse, Listenplatz : in Integer);
   procedure VerbesserungFertiggestellt (Rasse : in Integer);
   
private
   
   Wahl : Boolean;
   
   procedure VerbesserungeFestgelegt (Befehl : in Wide_Wide_Character; Rasse, Listenplatz : in Integer);
   procedure VerbesserungAngelegt (Rasse, Listenplatz : in Integer);

end VerbesserungenDatenbank;
