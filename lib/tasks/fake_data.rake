namespace :fake_data do
  task :db_reset => :environment do
    Rake::Task['db:reset'].invoke 
  end

  task :db_schema_load => :environment do
    Rake::Task['db:schema:load'].invoke 
  end

  task :groups => :environment do
    Rake::Task['groups'].invoke
  end

  task :people => :environment do
    Specialty.create([{name: 'Music', peerage_type: :laurel, slug: 'music'}, {name: 'Costuming', peerage_type: :laurel, slug: 'costuming'}, {name: 'Painting', peerage_type: :laurel, slug: 'painting'}, {name: 'Calligraphy & Illumination', peerage_type: :laurel, slug: 'calligraphy_and_illumination'}])

    byrd = User.create do |u|
      u.email = 'byrd@example.com'
      u.password = 'password' 
      u.sca_name = 'William Byrd'
      u.modern_name = 'Billy Birdman'
      u.street = 'Division Street'
      u.city = 'Ann Arbor'
      u.state = 'MI'
      u.zipcode = '48105'
      u.phone = '5556667777'
      u.deceased = false
      u.group = Group.find_by(name: 'Cynnabar')
    end


    Laurel.create do |p|
      p.active = true
      p.elevation_date = Date.parse('1560-May-10')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Motets'
      p.bio = 'I like Music. I am a **Catholic**.'
      p.admin = true
  		p.user_id = byrd.id
    end

    Defense.create do |p|
      p.active = true
      p.elevation_date = Date.parse('1560-May-10')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Motets'
      p.bio = 'I am a Master of Defense'
      p.admin = true
  		p.user_id = byrd.id
    end
    Pelican.create do |p|
      p.active = true
      p.elevation_date = Date.parse('1560-May-10')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Motets'
      p.bio = 'I am a Pelican Too!'
      p.admin = true
  		p.user_id = byrd.id
    end

		byrd.arms.attach(io: File.open('lib/assets/fake_data/byrd_coa.jpg'), filename: 'byrd_coa.jpg', content_type: 'image/jpeg');
		byrd.laurel.profile_pic.attach(io: File.open('lib/assets/fake_data/byrd.png'), filename: 'byrd.png', content_type: 'image/png');
		byrd.defense.profile_pic.attach(io: File.open('lib/assets/fake_data/byrd.png'), filename: 'byrd.png', content_type: 'image/png');
		byrd.pelican.profile_pic.attach(io: File.open('lib/assets/fake_data/byrd.png'), filename: 'byrd.png', content_type: 'image/png');
	
    Specialization.create(peer: byrd.laurel, specialty: Specialty.find_by(name: 'Music'))

    tallis = User.create do |u|
      u.email = 'tallis@example.com'
      u.password = 'password' 
      u.sca_name = 'Thomas Tallis'
      u.modern_name = 'Tommy Tallman'
      u.street = 'Somewhere'
      u.city = 'Chicago'
      u.state = 'IL'
      u.zipcode = ''
      u.phone = '5556667777'
      u.deceased = true
      u.group = Group.find_by(name: 'Tree Girt Sea')
    end
		Laurel.create do |p|
      p.active = false
      p.elevation_date = Date.parse('1532-Sept-05')
      p.elevated_by = 'Henry VIII'
      p.vigilant = false
      p.specialty_detail = 'Polyphony'
      p.bio = 'I liked Music First.'
      p.admin = false
			p.user = tallis
    end

    tallis.laurel.profile_pic.attach(io: File.open('lib/assets/fake_data/tallis.png'), filename: 'byrd_coa.jpg', content_type: 'image/png');
    Specialization.create(peer: tallis.laurel, specialty: Specialty.find_by(name: 'Music'))
    Dependency.create(peer: byrd.laurel, superior: tallis.laurel)


    dowland = User.create do |u|
      u.email = 'dowland@example.com'
      u.password = 'password' 
      u.sca_name = 'John Dowland'
      u.modern_name = 'Jonny Dowland'
      u.street = 'Somewhere'
      u.city = 'Bloomington'
      u.state = 'Indiana'
      u.zipcode = ''
      u.phone = '5556667777'
      u.deceased = false
      u.group = Group.find_by(name: 'Mynydd Seren')
    end

    Laurel.create do |p|
      p.active = false
      p.elevation_date = Date.parse('1570-Sept-05')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Lute Songs'
      p.bio = 'I am on of the first Singer Songwriters. No longer active because I moved to Paris.'
      p.admin = false
			p.user = dowland
    end

    dowland.laurel.profile_pic.attach(io: File.open('lib/assets/fake_data/dowland.png'), filename: 'dowland.png', content_type: 'image/png');
    morley = Candidate.create do |u|
      u.sca_name = 'Thomas Morley'
      u.vote = true
      u.group = Group.find_by(name: 'Northwoods')
      u.peerage_type = :laurel
    end    
		morley.profile_pic.attach(io: File.open('lib/assets/fake_data/morley.png'), filename: 'morley.png', content_type: 'image/png');
    Specialization.create(candidate: morley, specialty: Specialty.find_by(name: 'Music'))
    Advocacy.create(candidate: morley, peer: byrd.laurel)

    hilliard = User.create do |u|
      u.email = 'hilliard@example.com'
      u.password = 'password' 
      u.sca_name = 'Nicholas Hilliard'
      u.modern_name = 'Nick Hill'
      u.street = 'Somewhere'
      u.city = 'Columbus'
      u.state = 'OH'
      u.zipcode = ''
      u.phone = '5556667777'
      u.deceased = false
      u.group = Group.find_by(name: 'Middle Marches')
    end
    
    Laurel.create do |p|
      p.active = true
      p.elevation_date = Date.parse('1572-Jan-15')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Portraits'
      p.bio = 'Yay Painting.'
      p.admin = false
			p.user = hilliard
    end

    hilliard.laurel.profile_pic.attach(io: File.open('lib/assets/fake_data/hilliard.png'), filename: 'hilliard.png', content_type: 'image/png');

    Specialization.create(peer: hilliard.laurel, specialty: Specialty.find_by(name: 'Painting'))
    holbein = User.create do |u|
      u.email = 'holbein@example.com'
      u.password = 'password' 
      u.sca_name = 'Hans Holbein the Younger'
      u.modern_name = 'Henry Holiday'
      u.street = 'Somewhere'
      u.city = 'Columbus'
      u.state = 'OH'
      u.zipcode = ''
      u.phone = '5556667777'
      u.deceased = false
      u.group = Group.find_by(name: 'Middle Marches')
    end
    
    Laurel.create do |p|
      p.active = true
      p.elevation_date = Date.parse('1572-Jan-15')
      p.elevated_by = 'Elizabeth I'
      p.vigilant = false
      p.specialty_detail = 'Portraits'
      p.bio = 'Yay Painting.'
      p.admin = false
			p.user = holbein
    end
    Specialization.create(peer: holbein.laurel, specialty: Specialty.find_by(name: 'Painting'))
    holbein.laurel.profile_pic.attach(io: File.open('lib/assets/fake_data/hans.png'), filename: 'hans.png', content_type: 'image/png')

    oliver = Candidate.create do |u|
      u.sca_name = 'Isaac Oliver'
      u.vote = false
      u.group = Group.find_by(name: 'Roaring Wastes')
      u.peerage_type = :laurel
    end    
		oliver.profile_pic.attach(io: File.open('lib/assets/fake_data/oliver.png'), filename: 'morley.png', content_type: 'image/png');
    d1 = Document.create(candidate:oliver, peer: byrd.laurel, name: 'First Image')
    d1.document.attach(io:  File.open('lib/assets/fake_data/oliver_1.jpg'), filename: 'oliver_1.jpg', content_type: 'image/jpeg')
    d2 = Document.create(candidate:oliver, peer: byrd.laurel, name: 'Second Image')
    d2.document.attach(io:  File.open('lib/assets/fake_data/oliver_2.jpg'), filename: 'oliver_2.jpg', content_type: 'image/jpeg')

    Specialization.create(candidate: oliver, specialty: Specialty.find_by(name: 'Painting'))
    Advocacy.create(candidate: oliver, peer: hilliard.laurel)
    Advocacy.create(candidate: oliver, peer: holbein.laurel)

    elizabeth = User.create do |u|
      u.email = 'elizabeth@example.com'
      u.password = 'password' 
      u.sca_name = 'Elizabeth I'
      u.modern_name = 'Lizzy Tudor'
      u.deceased = false
      u.royalty = true
      u.street = nil
      u.city = nil
      u.state = nil
      u.zipcode = nil
      u.phone = nil
      u.group = nil
    end
### comments
    Comment.create do |c|
      c.candidate = morley
      c.peer = byrd.laurel
      c.text = "I don't know why he's so focused on Madrigals. Latin polyphony is what he should be doing. Also, isn't that a picture of John Bull?" 
    end
    Comment.create do |c|
      c.candidate = morley
      c.peer = hilliard.laurel
      c.text = "I love his music. It's so full of feelings. Great for Beginners!" 
    end
    Comment.create do |c|
      c.candidate = morley
      c.peer = holbein.laurel
      c.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus semper nunc. Sed ligula quam, euismod at arcu vitae, fermentum dictum felis. Nunc porta ex et eros hendrerit lacinia. In mattis nunc at felis aliquet, vitae varius leo mollis. Aenean congue sagittis rutrum. Aliquam mattis orci ac ornare porta. Integer mollis ullamcorper justo, ut fermentum neque volutpat eu. Cras viverra ex ut libero gravida tincidunt id in leo. Nulla mattis sollicitudin diam eget commodo. Nam dui odio, volutpat sed erat a, tempus maximus diam. Nunc dictum enim vitae dolor venenatis, vitae vulputate orci sodales. In hac habitasse platea dictumst. Aliquam erat volutpat. Quisque gravida sem et eros accumsan ultricies. Morbi ante tellus, semper at commodo sit amet, pharetra vitae mauris. Nulla at viverra mi, vel congue ex.

In eget erat vestibulum, placerat nunc ut, dapibus enim. Sed non sem nec velit mollis iaculis. Ut rhoncus finibus felis, ac interdum quam accumsan ac. Praesent nunc nisl, tempus quis pretium sed, semper in diam. Curabitur id imperdiet ligula. Fusce non felis dolor. Phasellus auctor est mi, eget dignissim sem ullamcorper nec. Nam purus orci, hendrerit non iaculis vel, posuere molestie eros. Fusce posuere efficitur neque, eget varius justo sodales at.

Nunc vehicula purus elementum, volutpat mauris ac, imperdiet ante. Pellentesque pretium ut erat sed egestas. Nulla facilisi. Aliquam ac cursus elit, pharetra cursus justo. Donec facilisis egestas eros facilisis vestibulum. Suspendisse nec tristique quam. Vivamus metus ante, condimentum non viverra ac, mollis nec diam.

Mauris iaculis lectus lacinia ex porta, a ullamcorper enim auctor. Duis tempus tincidunt arcu sed blandit. In sed sodales augue, vitae pretium neque. Pellentesque nec dapibus felis. Fusce lacinia nibh purus, venenatis blandit nunc ullamcorper ut. Etiam sed blandit massa. Sed condimentum cursus mollis. Vestibulum nec felis non ante tempus sollicitudin. Etiam sollicitudin urna vitae lacinia aliquet. Mauris imperdiet quam hendrerit libero tincidunt, et condimentum odio convallis. Aliquam erat volutpat. Proin urna justo, sodales faucibus auctor sed, sodales et risus.

Proin sit amet turpis nec velit euismod sodales at non libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu congue ligula. Aenean tincidunt mauris eros, facilisis malesuada leo vulputate eu. Aliquam viverra sollicitudin turpis." 
    end
  
    Comment.create do |c|
      c.candidate = oliver
      c.peer = hilliard.laurel
      c.text = "He's getting better! He's teaching at RUM" 
    end
    Comment.create do |c|
      c.candidate = oliver
      c.peer = byrd.laurel
      c.text = "I took his class on portraiture. He's a good teacher. I think he's ready for the vote list." 
    end
    Comment.create do |c|
      c.candidate = oliver
      c.peer = holbein.laurel
      c.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus semper nunc. Sed ligula quam, euismod at arcu vitae, fermentum dictum felis. Nunc porta ex et eros hendrerit lacinia. In mattis nunc at felis aliquet, vitae varius leo mollis. Aenean congue sagittis rutrum. Aliquam mattis orci ac ornare porta. Integer mollis ullamcorper justo, ut fermentum neque volutpat eu. Cras viverra ex ut libero gravida tincidunt id in leo. Nulla mattis sollicitudin diam eget commodo. Nam dui odio, volutpat sed erat a, tempus maximus diam. Nunc dictum enim vitae dolor venenatis, vitae vulputate orci sodales. In hac habitasse platea dictumst. Aliquam erat volutpat. Quisque gravida sem et eros accumsan ultricies. Morbi ante tellus, semper at commodo sit amet, pharetra vitae mauris. Nulla at viverra mi, vel congue ex.

In eget erat vestibulum, placerat nunc ut, dapibus enim. Sed non sem nec velit mollis iaculis. Ut rhoncus finibus felis, ac interdum quam accumsan ac. Praesent nunc nisl, tempus quis pretium sed, semper in diam. Curabitur id imperdiet ligula. Fusce non felis dolor. Phasellus auctor est mi, eget dignissim sem ullamcorper nec. Nam purus orci, hendrerit non iaculis vel, posuere molestie eros. Fusce posuere efficitur neque, eget varius justo sodales at.

Nunc vehicula purus elementum, volutpat mauris ac, imperdiet ante. Pellentesque pretium ut erat sed egestas. Nulla facilisi. Aliquam ac cursus elit, pharetra cursus justo. Donec facilisis egestas eros facilisis vestibulum. Suspendisse nec tristique quam. Vivamus metus ante, condimentum non viverra ac, mollis nec diam.

Mauris iaculis lectus lacinia ex porta, a ullamcorper enim auctor. Duis tempus tincidunt arcu sed blandit. In sed sodales augue, vitae pretium neque. Pellentesque nec dapibus felis. Fusce lacinia nibh purus, venenatis blandit nunc ullamcorper ut. Etiam sed blandit massa. Sed condimentum cursus mollis. Vestibulum nec felis non ante tempus sollicitudin. Etiam sollicitudin urna vitae lacinia aliquet. Mauris imperdiet quam hendrerit libero tincidunt, et condimentum odio convallis. Aliquam erat volutpat. Proin urna justo, sodales faucibus auctor sed, sodales et risus.

Proin sit amet turpis nec velit euismod sodales at non libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu congue ligula. Aenean tincidunt mauris eros, facilisis malesuada leo vulputate eu. Aliquam viverra sollicitudin turpis." 
    end
### poll
    poll = Poll.new do |p|
      p.start_date = DateTime.now - 5.days
      p.end_date = DateTime.now - 1.days
      p.peerage_type = :laurel
    end
    poll.save(validate: false)

    Advising.create do |a|
      a.poll = poll
      a.peer = byrd.laurel
      a.candidate = morley
      a.judgement = :wait
      a.comment = 'I do not believe he is ready yet.'
    end
    Advising.create do |a|
      a.poll = poll
      a.peer = hilliard.laurel
      a.candidate = morley
      a.judgement = :wait
      a.comment = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus semper nunc. Sed ligula quam, euismod at arcu vitae, fermentum dictum felis. Nunc porta ex et eros hendrerit lacinia. In mattis nunc at felis aliquet, vitae varius leo mollis. Aenean congue sagittis rutrum. Aliquam mattis orci ac ornare porta. Integer mollis ullamcorper justo, ut fermentum neque volutpat eu. Cras viverra ex ut libero gravida tincidunt id in leo. Nulla mattis sollicitudin diam eget commodo. Nam dui odio, volutpat sed erat a, tempus maximus diam. Nunc dictum enim vitae dolor venenatis, vitae vulputate orci sodales. In hac habitasse platea dictumst. Aliquam erat volutpat. Quisque gravida sem et eros accumsan ultricies. Morbi ante tellus, semper at commodo sit amet, pharetra vitae mauris. Nulla at viverra mi, vel congue ex.

In eget erat vestibulum, placerat nunc ut, dapibus enim. Sed non sem nec velit mollis iaculis. Ut rhoncus finibus felis, ac interdum quam accumsan ac. Praesent nunc nisl, tempus quis pretium sed, semper in diam. Curabitur id imperdiet ligula. Fusce non felis dolor. Phasellus auctor est mi, eget dignissim sem ullamcorper nec. Nam purus orci, hendrerit non iaculis vel, posuere molestie eros. Fusce posuere efficitur neque, eget varius justo sodales at.

Nunc vehicula purus elementum, volutpat mauris ac, imperdiet ante. Pellentesque pretium ut erat sed egestas. Nulla facilisi. Aliquam ac cursus elit, pharetra cursus justo. Donec facilisis egestas eros facilisis vestibulum. Suspendisse nec tristique quam. Vivamus metus ante, condimentum non viverra ac, mollis nec diam.

Mauris iaculis lectus lacinia ex porta, a ullamcorper enim auctor. Duis tempus tincidunt arcu sed blandit. In sed sodales augue, vitae pretium neque. Pellentesque nec dapibus felis. Fusce lacinia nibh purus, venenatis blandit nunc ullamcorper ut. Etiam sed blandit massa. Sed condimentum cursus mollis. Vestibulum nec felis non ante tempus sollicitudin. Etiam sollicitudin urna vitae lacinia aliquet. Mauris imperdiet quam hendrerit libero tincidunt, et condimentum odio convallis. Aliquam erat volutpat. Proin urna justo, sodales faucibus auctor sed, sodales et risus.

Proin sit amet turpis nec velit euismod sodales at non libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu congue ligula. Aenean tincidunt mauris eros, facilisis malesuada leo vulputate eu. Aliquam viverra sollicitudin turpis.'
    end
    Advising.create do |a|
      a.poll = poll
      a.peer = holbein.laurel
      a.candidate = morley
      a.judgement = :drop
      a.comment = 'No way man.'
    end
    Advising.create do |a|
      a.poll = poll
      a.peer = byrd.laurel
      a.candidate = oliver
      a.judgement = :elevate
      a.comment = 'Looks great!'
    end
    Advising.create do |a|
      a.poll = poll
      a.peer = hilliard.laurel
      a.candidate = oliver
      a.judgement = :elevate
      a.comment = 'Looks great!'
    end
    Advising.create do |a|
      a.poll = poll
      a.peer = holbein.laurel
      a.candidate = oliver
      a.judgement = :drop
      a.comment = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus semper nunc. Sed ligula quam, euismod at arcu vitae, fermentum dictum felis. Nunc porta ex et eros hendrerit lacinia. In mattis nunc at felis aliquet, vitae varius leo mollis. Aenean congue sagittis rutrum. Aliquam mattis orci ac ornare porta. Integer mollis ullamcorper justo, ut fermentum neque volutpat eu. Cras viverra ex ut libero gravida tincidunt id in leo. Nulla mattis sollicitudin diam eget commodo. Nam dui odio, volutpat sed erat a, tempus maximus diam. Nunc dictum enim vitae dolor venenatis, vitae vulputate orci sodales. In hac habitasse platea dictumst. Aliquam erat volutpat. Quisque gravida sem et eros accumsan ultricies. Morbi ante tellus, semper at commodo sit amet, pharetra vitae mauris. Nulla at viverra mi, vel congue ex.

In eget erat vestibulum, placerat nunc ut, dapibus enim. Sed non sem nec velit mollis iaculis. Ut rhoncus finibus felis, ac interdum quam accumsan ac. Praesent nunc nisl, tempus quis pretium sed, semper in diam. Curabitur id imperdiet ligula. Fusce non felis dolor. Phasellus auctor est mi, eget dignissim sem ullamcorper nec. Nam purus orci, hendrerit non iaculis vel, posuere molestie eros. Fusce posuere efficitur neque, eget varius justo sodales at.

Nunc vehicula purus elementum, volutpat mauris ac, imperdiet ante. Pellentesque pretium ut erat sed egestas. Nulla facilisi. Aliquam ac cursus elit, pharetra cursus justo. Donec facilisis egestas eros facilisis vestibulum. Suspendisse nec tristique quam. Vivamus metus ante, condimentum non viverra ac, mollis nec diam.

Mauris iaculis lectus lacinia ex porta, a ullamcorper enim auctor. Duis tempus tincidunt arcu sed blandit. In sed sodales augue, vitae pretium neque. Pellentesque nec dapibus felis. Fusce lacinia nibh purus, venenatis blandit nunc ullamcorper ut. Etiam sed blandit massa. Sed condimentum cursus mollis. Vestibulum nec felis non ante tempus sollicitudin. Etiam sollicitudin urna vitae lacinia aliquet. Mauris imperdiet quam hendrerit libero tincidunt, et condimentum odio convallis. Aliquam erat volutpat. Proin urna justo, sodales faucibus auctor sed, sodales et risus.

Proin sit amet turpis nec velit euismod sodales at non libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu congue ligula. Aenean tincidunt mauris eros, facilisis malesuada leo vulputate eu. Aliquam viverra sollicitudin turpis.'
    end
  end
  task :all => [:db_reset, :groups, :people]
  task :all_heroku => [:db_schema_load, :groups, :people]
end
